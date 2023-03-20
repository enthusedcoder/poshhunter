# Poshhunter

## Introduction

This powershell module is meant to act as a wrapper around the [hunter.io api](https://hunter.io).  This particular api offers some truely unique capabilites too, including but not limited to:

* Listing all email addresses found for a specified domain or company name
* Determining the most likely email address for an individual given their name and their domain or company name
* Verifying the the deliverability of an email address
* More likely to come

The module contains functions to utilize all of its api endpoints.

## Installation

In order to use the module, you need to have at least powershell 5 installed on your computer and run the following command:

```powershell
Install-module poshhunter -force -allowclobber
```

## How to use

In order to use this module, you will need to register for a [hunter.io account](https://hunter.io) in order to generate an api key.  Once you have done this, import the api key by running the below command:

```powershell
import-apitoken -apikey <your api token>
```

To list the functions in the module, run the below command:

```powershell
Get-command -module poshhunter
```

This module has built in help content for each of the functions in the module that can be accessed with "get-help"