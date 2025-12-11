SXYautoInstall: 
====

📦 功能概述
此工具旨在解决 R 包安装过程中的常见问题：

🔧 核心功能
GitHub 源安装问题 - 处理从 GitHub 下载 R 包时的网络和依赖问题

智能包源识别 - 自动识别并正确处理来自不同源的 R 包：

CRAN（官方仓库）

Bioconductor（生物信息学仓库）

GitHub（开发版本）

综合问题解决 - 一站式处理安装过程中的多种问题

🛠️ 解决的问题
问题类型	具体表现	解决方案
版本混乱	多版本冲突、依赖不匹配	自动版本检测与协调
编译失败	源代码编译错误、编译器缺失	预编译检查与依赖安装
系统库缺失	缺少系统级依赖库	自动检测并安装系统依赖


## 1 安装数信院SXYautoInstall包（Install the SXYautoInstall package）

```{r eval = FALSE}
install.packages("remotes")
remotes::install_github("EddieLv/SXYautoInstall", force=T)
library(SXYautoInstall)
```

## 2 安装来自CRAN和Bioconductor的R包（Install R packages from CRAN and Bioconductor）

### 2.1 使用CRAN和Bioconductor官方通道（CRAN and Bioconductor official channels）

```{r eval = FALSE}
#For example
##For CRAN
SXY_install_package_auto("dplyr")
##For Bioconductor
SXY_install_package_auto("limma")
```

### 2.2 使用CRAN和Bioconductor国内镜像（CRAN and Bioconductor mirrors）

```{r eval = FALSE}
#For example
##For CRAN tsinghua mirrors
SXY_install_package_auto(pkg_name = "dplyr", cran_mirror = "https://mirrors.tuna.tsinghua.edu.cn/CRAN/", bioc_mirror = "https://mirrors.tuna.tsinghua.edu.cn/bioconductor/")
##For Bioconductor westlake mirrors
SXY_install_package_auto(pkg_name = "limma", cran_mirror = "https://mirrors.westlake.edu.cn/CRAN/", bioc_mirror = "https://mirrors.westlake.edu.cn/bioconductor/")
```

##  🚀 安装来自github的R包（R packages from GitHub）

```{r eval = FALSE}
#For example（Author's Name/Package Name）
SXY_install_package_auto("dviraran/xCell")
```

##  示例过程（Example process）

![](https://files.mdnice.com/user/101751/fd44e0d5-5bfe-4896-9318-0ba7683feb46.png)


![Uploading d47e0b505cdf6ca977e6e2023819edca.png…]()
