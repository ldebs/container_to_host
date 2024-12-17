# Purpose

The purpose of this template project is to demonstrate how to execute commands from within a container into its host environment. The test scripts provided enable the execution of commands in the host's shell, capturing both standard output and error streams in real-time.

# Project Structure

```
/host.sh
/container/
\__ /entrypoint.sh
\__ /scripts/
    \__ 1_base/
    \__ 2_run_host/
    \__ test/
```

- **Host Script (`host.sh`)**: This script is designed to facilitate communication between a container and its host environment. It creates several named pipes and files for inter-process communication and runs the container with the appropriate environment variables and volume bindings.

- **Entrypoint Script (`container/entrypoint.sh`)**: This serves as the main entry point of the container, responsible for executing other scripts. It runs a series of initialization scripts and test scripts. It also handles logging for each script execution.

- **Initialization Scripts**
   - Located in `container/scripts/[1-2]*/*.sh`, these scripts provide helper functions to orchestrate script execution.
   - The scripts in the `1_base` directory define color variables, handle errors, and manage logs. These are sourced by both the `host.sh` and `entrypoint.sh` scripts.
   - The script in the `2_run_host` directory handles inter-process communication on the container side. It is sourced exclusively by the `entrypoint.sh` script.

- **Test Scripts**: Located in `container/scripts/test/*.sh`, these scripts demonstrate how to execute commands on the host via the container.

# Key Concepts

## Host process

Host script provides named pipes (`HOST_CMD`, `HOST_STS`, `HOST_OUT`, `HOST_ERR`) and a file `HOST_IN` to manage inter-process communication. 

Once the pipes have been created, an infinite loop listens for new commands arriving on the `HOST_CMD` named pipe. These commands are packaged into a temporary script, which is then executed with its stdout and stderr redirected to the `HOST_OUT` and `HOST_ERR` named pipes, respectively, and its stdin redirected from the `HOST_IN` file. The return status of the command script is subsequently written to the `HOST_STS` named pipe. On a trap exit signal, the host process kills the infinite loop.

In parallel, the host process runs the container and waits for it to complete. 

## Container process

Named pipes (`HOST_CMD`, `HOST_STS`, `HOST_OUT`, `HOST_ERR`) and `HOST_IN` file are passed to the container via environment variables and bound as volumes.

Before executing host commands, the container process writes the expected input to the `HOST_IN` file and then calls the `run_host` function with the commands to be executed as arguments. This function starts two infinite loops to read from `HOST_OUT` and `HOST_ERR`, writing the received streams to stdout and stderr, respectively. It subsequently writes the commands to `HOST_CMD`. The function then waits for the status result on `HOST_STS`. Once the status is received, it kills the read loops and returns the status.

The content of `stdout` and `stderr` produced by host commands can be retrieved via the `REPLY_OUT` and `REPLY_ERR` variables after executing the `run_host` function.

## Contributing

- **How to Contribute**:
  - Contributions are welcome from anyone who is interested in improving this template. If you have a bug fix or a new feature that you think would be useful, please follow these steps:
    1. Fork the repository to your own GitHub account.
    2. Create a new branch for your changes.
    3. Make your changes and commit them with descriptive messages.
    4. Push your changes to your forked repository.
    5. Submit a pull request to the original repository.

- **Coding Standards**:
  - To ensure consistency and maintainability, please adhere to the following coding standards:
    - Use consistent indentation (e.g., 2 spaces per indentation level).
    - Follow a consistent naming convention for variables, functions, and scripts.
    - Comment your code where necessary to explain complex logic or important decisions.

- **Issue Reporting**:
  - If you encounter any issues or have suggestions for improvements, please report them through the GitHub Issues page. Please provide as much detail as possible, including:
    - A clear description of the issue.
    - Steps to reproduce the issue.
    - The expected behavior and the actual behavior.

## License

- **License Information**:

[![Creative Commons License](https://i.creativecommons.org/l/by-nc-sa/4.0/88x31.png)](http://creativecommons.org/licenses/by-nc-sa/4.0/)
  
This project owned by [ldebs](https://www.ldebs.org/artnet2dmx) is licensed under a [Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License](http://creativecommons.org/licenses/by-nc-sa/4.0/).
