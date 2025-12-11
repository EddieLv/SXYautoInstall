# -*- coding: utf-8 -*-


#' Configure custom CRAN and Bioconductor mirrors
#' 
#' Automatically set specified CRAN and Bioconductor mirror addresses
#' @param cran_mirror Character, CRAN mirror address (default: Westlake University)
#' @param bioc_mirror Character, Bioconductor mirror address (default: Westlake University)
#' @export 
set_custom_mirrors <- function(
    cran_mirror = "https://cran.r-project.org/",
    bioc_mirror = "https://bioconductor.org/"
) {
  options(repos = c(CRAN = cran_mirror))
  options(BioC_mirror = bioc_mirror)
  message("CRAN和Bioconductor镜像已配置完成！")  
  message(paste("CRAN镜像: ", cran_mirror))
  message(paste("Bioconductor镜像: ", bioc_mirror))
}

#' Auto install R packages by source (SXY version, CRAN first)
#' 
#' Automatically identify package source (GitHub > CRAN > Bioconductor) and install, 
#' with all dependencies and no auto-update. CRAN is checked first, then Bioconductor.
#' @param pkg_name Character, package name (pure name or author/package format for GitHub)
#' @param cran_mirror Character, custom CRAN mirror address (default: Westlake University)
#' @param bioc_mirror Character, custom Bioconductor mirror address (default: Westlake University)
#' @export 
SXY_install_package_auto <- function(
    pkg_name,
    cran_mirror = "http://mirrors.westlake.edu.cn/CRAN",
    bioc_mirror = "http://mirrors.westlake.edu.cn/bioconductor"
) {
  if (missing(pkg_name) || is.null(pkg_name) || pkg_name == "") {
    stop("错误：必须指定'pkg_name'参数！请输入包名（例如：'dplyr' 或 'tidyverse/tidyverse'）。")
  }
  
  # 配置自定义镜像
  set_custom_mirrors(cran_mirror = cran_mirror, bioc_mirror = bioc_mirror)
  
  # 禁用交互式提示
  old_ask <- options(install.packages.ask = FALSE)
  on.exit(options(old_ask))
  
  ad_text <- "欢迎使用SXY数信云服务器!"
  ad_border <- "======================================"
  
  # 提取纯包名
  pure_pkg_name <- if (grepl("/", pkg_name)) {
    strsplit(pkg_name, "/")[[1]][2]
  } else {
    pkg_name
  }
  
  # 安装GitHub包
  if (grepl("/", pkg_name)) {
    message(paste("识别到GitHub包格式: ", pkg_name, "，开始安装..."))
    install_success <- FALSE
    
    # 尝试main分支
    message("第一次尝试：main分支")
    github_url_main <- paste0("https://ghfast.top/https://github.com/", pkg_name, "/archive/refs/heads/main.zip")
    message(paste("下载地址: ", github_url_main))
    
    tryCatch({
      if (!requireNamespace("devtools", quietly = TRUE)) {
        message("未找到devtools包，先从CRAN安装...")
        install.packages("devtools", repos = getOption("repos"), update = FALSE, dependencies = TRUE)
        if (!requireNamespace("devtools", quietly = TRUE)) {
          stop("devtools包安装失败！无法安装GitHub包。")
        }
      }
      
      devtools::install_url(
        url = github_url_main,
        quiet = TRUE,
        upgrade = "never",
        dependencies = TRUE
      )
      
      if (requireNamespace(pure_pkg_name, quietly = TRUE)) {
        message(paste("GitHub包 ", pkg_name, " (main分支) 安装成功！"))
        message(ad_border)
        message(ad_text)
        message(ad_border)
        install_success <- TRUE
      } else {
        stop("包已下载但无法加载（分支/压缩包无效）")
      }
    }, error = function(e) {
      message(paste("main分支安装失败: ", substr(e$message, 1, 80), "..."))
      message("进行第二次尝试：master分支")
    })
    
    # main分支失败则尝试master分支
    if (!install_success) {
      github_url_master <- paste0("https://ghfast.top/https://github.com/", pkg_name, "/archive/refs/heads/master.zip")
      message(paste("下载地址: ", github_url_master))
      
      tryCatch({
        devtools::install_url(
          url = github_url_master,
          quiet = TRUE,
          upgrade = "never",
          dependencies = TRUE
        )
        
        if (requireNamespace(pure_pkg_name, quietly = TRUE)) {
          message(paste("GitHub包 ", pkg_name, " (master分支) 安装成功！"))
          message(ad_border)
          message(ad_text)
          message(ad_border)
          install_success <- TRUE
        } else {
          stop("包已下载但无法加载（分支/压缩包无效）")
        }
      }, error = function(e) {
        message(paste("master分支安装失败: ", substr(e$message, 1, 80), "..."))
      })
    }
    
    if (!install_success) {
      stop(paste("GitHub包 ", pkg_name, " 的main/master分支均安装失败！"))
    }
    return(invisible(NULL))
  }
  
  # 安装CRAN包
  cran_repos <- getOption("repos")
  cran_pkgs <- tryCatch({
    available.packages(repos = cran_repos)[, "Package"]
  }, error = function(e) {
    message(paste("获取CRAN包列表失败: ", e$message))
    character(0)
  })
  
  if (pkg_name %in% cran_pkgs) {
    message(paste("在CRAN中找到 ", pkg_name, "，开始从CRAN安装..."))
    tryCatch({
      install.packages(
        pkgs = pkg_name,
        repos = cran_repos,
        update = FALSE,
        dependencies = TRUE
      )
      
      if (requireNamespace(pkg_name, quietly = TRUE)) {
        message(paste("CRAN包 ", pkg_name, " 安装成功！"))
        message(ad_border)
        message(ad_text)
        message(ad_border)
      } else {
        stop("包已安装但无法加载")
      }
    }, error = function(e) {
      message(paste("CRAN包 ", pkg_name, " 安装失败: ", e$message))
    })
    return(invisible(NULL))
  }
  
  # 安装Bioconductor包
  message(paste("未在CRAN中找到 ", pkg_name, "，尝试从Bioconductor安装..."))
  if (!requireNamespace("BiocManager", quietly = TRUE)) {
    message("未找到BiocManager包，先从CRAN安装...")
    install.packages("BiocManager", repos = cran_repos, update = FALSE, dependencies = TRUE)
    if (!requireNamespace("BiocManager", quietly = TRUE)) {
      stop("BiocManager包安装失败！无法安装Bioconductor包。")
    }
  }
  
  tryCatch({
    BiocManager::install(
      pkgs = pkg_name,
      update = FALSE,
      ask = FALSE,
      dependencies = TRUE
    )
    
    if (requireNamespace(pkg_name, quietly = TRUE)) {
      message(paste("Bioconductor包 ", pkg_name, " 安装成功！"))
      message(ad_border)
      message(ad_text)
      message(ad_border)
    } else {
      stop("包已安装但无法加载")
    }
  }, error = function(e) {
    message(paste("Bioconductor包 ", pkg_name, " 安装失败: ", e$message))
    stop(paste("包 ", pkg_name, " 未在CRAN/Bioconductor/GitHub中找到！"))
  })
  return(invisible(NULL))
}