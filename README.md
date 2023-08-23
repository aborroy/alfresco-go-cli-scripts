# Alfresco CLI Scripts

Collection of scripts to be used with the [Alfresco Go CLI](https://github.com/aborroy/alfresco-go-cli).

## Usage

Download the **alfresco** binary compiled for your architecture (Linux, Windows or Mac OS) from [**Releases**](https://github.com/aborroy/alfresco-go-cli/releases).

>> You may rename the binary to `alfresco`, all the following samples are using this command name by default.

Before using interactive commands with Alfresco Repository, defining connection and credentails is required.

Following command will store a connection for ACS deployed in `localhost` with default credentials (admin/admin)

```
./alfresco config set -s http://localhost:8080/alfresco -u admin -p admin
```

>> Note that this command will create a `.alfresco` configuration file on the same folder

## Logs

Local file `alfresco.log` is capturing command logs. The log file includes activity entries and error details.

## Running the scripts

Sample bash scripts for testing purposes are provided:

* [create-update.sh][create-update.sh] creates 1,000 local files, upload the files to Alfresco Repository and update some properties for each of these files in the Repository

>> Before running the script, running Alfresco server in specified URL (e.g. http://localhost:8080/alfresco) is required 

## Documentation

Detailed documentation for **alfresco** program is available in [docs/alfresco.md](https://github.com/aborroy/alfresco-go-cli/blob/main/docs/alfresco.md)
