[![img](https://img.shields.io/badge/Lifecycle-Experimental-339999)](https://github.com/bcgov/repomountie/blob/master/doc/lifecycle-badges.md)[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

## safepaths

An R package 📦 to safely set & use a path to a private network.

### Features

The package has 3 functions to safely set & use a path to a private network:

 - `set_network_path()`: adds an environment variable called `SAFEPATHS_NETWORK_PATH` to
    your `.Renviron` file and sets the variable to a provided network
    path.
    
 - `get_network_path()`: retrieves the environment variable `SAFEPATHS_NETWORK_PATH`, which is stored in your `.Renviron` file using `set_network_path()`.
 
 - `use_network_path()`: retrieves and uses the stored network path in conjunction with a  provided file or folder path. 
 
 
```{r}
use_network_path("file.csv")
use_network_path("folder_name/file.csv")
```

### Installation

You can install the package directly from this repository. To do so, you
will need the [remotes](https://github.com/hadley/devtools/) package:

``` r
install.packages("remotes")
```

Next, install `safepaths` package using
`remotes::install_github()`:

``` r
library("remotes")
install_github("bcgov/safepaths")
```

### Project Status

In Progress

### Getting Help or Reporting an Issue

To report bugs/issues/feature requests, please file an [issue](https://github.com/bcgov/safepaths/issues/).

### How to Contribute

If you would like to contribute to the package, please see our [CONTRIBUTING](CONTRIBUTING.md) guidelines.

Please note that this project is released with a [Contributor Code of Conduct](CODE_OF_CONDUCT.md). By participating in this project you agree to abide by its terms.

### License

```
Copyright 2020 Province of British Columbia

Licensed under the Apache License, Version 2.0 (the &quot;License&quot;);
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an &quot;AS IS&quot; BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and limitations under the License.
```

---
*This project was created using the [bcgovr](https://github.com/bcgov/bcgovr) package.* 
