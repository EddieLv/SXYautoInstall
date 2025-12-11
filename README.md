SXYautoInstall: 
====

🚀 功能概述
此工具旨在解决 R 包安装过程中的常见问题：

🔧 核心功能
GitHub 源安装问题 - 处理从 GitHub 下载 R 包时的网络和依赖问题

智能包源识别 - 自动识别并正确处理来自不同源的 R 包：

CRAN（官方仓库）

Bioconductor（生物信息学仓库）

GitHub（开发版本）

🛠️ 综合问题解决 - 一站式处理安装过程中的多种问题
<div style="display: flex; flex-direction: column; gap: 10px; margin: 20px 0;"><div style="border-left: 4px solid #ff6b6b; padding: 15px; background: #fff5f5;"> <strong>🚨 版本混乱</strong><br> <small>🔍 多版本冲突、依赖不匹配</small><br> ✅ <strong>解决方案：</strong>自动版本检测与协调 </div><div style="border-left: 4px solid #4ecdc4; padding: 15px; background: #f0f9ff;"> <strong>🔨 编译失败</strong><br> <small>🔍 源代码编译错误、编译器缺失</small><br> ✅ <strong>解决方案：</strong>预编译检查与依赖安装 </div><div style="border-left: 4px solid #ffe66d; padding: 15px; background: #fffaf0;"> <strong>📚 系统库缺失</strong><br> <small>🔍 缺少系统级依赖库</small><br> ✅ <strong>解决方案：</strong>自动检测并安装系统依赖 </div></div>


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

数信云为生信初学者们搭建了CRAN和Bioconducto国内镜像，下载速度高达100MB/s，但是由于带宽价格高昂，目前仅限数信院服务器用户使用！

这是使用数信云生信镜像的教程https://book.sxycloud.com/C3/C3.1.html

🚀 SXY自建cran镜像源: http://sxygptcloud.com:6003/cran

🚀 SXY自建bioconductor镜像源(包含bioconductor官方3.9-3.22完整版本，清华镜像都不具备): http://sxygptcloud.com:6004/bioconductor

```{r eval = FALSE}
#For example
##For CRAN tsinghua mirrors
SXY_install_package_auto(pkg_name = "dplyr", cran_mirror = "https://mirrors.tuna.tsinghua.edu.cn/CRAN/", bioc_mirror = "https://mirrors.tuna.tsinghua.edu.cn/bioconductor/")
##For Bioconductor westlake mirrors
SXY_install_package_auto(pkg_name = "limma", cran_mirror = "https://mirrors.westlake.edu.cn/CRAN/", bioc_mirror = "https://mirrors.westlake.edu.cn/bioconductor/")
```

## 3 安装来自github的R包（R packages from GitHub）

```{r eval = FALSE}
#For example（Author's Name/Package Name）
SXY_install_package_auto("dviraran/xCell")
```

##  安装并使用本软件的示例过程（Example process）
<img width="1649" height="776" alt="3f1268aa63b032a1586a1ce37791731b" src="https://github.com/user-attachments/assets/5a4f15b8-89ad-4cd1-9cdf-04d91966853b" />

本项目为开源项目，欢迎大家在issues提交建议和bug！！！
