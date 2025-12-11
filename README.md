SXYautoInstall: 
====

用于解决：

1.来源于GitHub的R包无法下载；

2.CRAN和Bioconductor上R包的自动识别和安装；

3.版本混乱 + 编译失败 + 系统库缺失。

Used to solve problems:

1.R packages from GitHub cannot be downloaded.

2.Automatic identification and installation of R packages on CRAN and Bioconductor.

3.Version inconsistencies + compilation failures + missing system libraries.


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
