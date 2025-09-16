# PatchWise

[![Python](https://img.shields.io/badge/Python-3776AB?logo=python&logoColor=white)](https://www.python.org/downloads/)
[![Docker](https://img.shields.io/badge/Docker-2496ED?logo=docker&color=%232496ED&logoColor=white)](https://docs.docker.com/engine/install/)
[![Discord](https://img.shields.io/discord/1095352552096268288?style=social&logo=discord&label=Discord)](https://discord.com/invite/qualcommdevelopernetwork)

> **PatchWise** automates patch review and static analysis for the Linux kernel, streamlining upstream contributions and ensuring code quality.

---

## Table of Contents

- [Features](#features)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
- [Usage](#usage)
- [Command-Line Options](#command-line-options)
- [Development](#development)
- [Contact](#getting-in-contact)
- [License](#license)

---

## Features

- **Automated Static Analysis**: Comprehensive suite of kernel-specific analysis tools (checkpatch, sparse, coccicheck, dt_check, dtbs_check, *more to come in future releases*)
- **AI-Powered Code Review**: Advanced code analysis using Language Server Protocol (LSP) with clangd for context-aware insights
- **Multi-model Compatibility**: Support for multiple LLMs and providers, such as OpenAI, for commit message analysis and code review
- **Reproducible Environments**: Docker-based isolation ensures consistent results across different systems
- **Containerized Patch Reviews**: Each review tool runs in its own isolated Docker container, preventing dependency conflicts
- **Flexible Review Selection**: Choose which review checks to run based on your needs
- **Integration with Mailing Lists** [*coming soon*]: Processes patches sent via email and responds automatically
- **Shared Build Artifacts** [*WIP*]: Efficient volume management for kernel compilation and analysis data

---

## Getting Started

### Prerequisites

- **Docker**: [Docker Engine 20.10+](https://docs.docker.com/engine/install/) with BuildKit support
- **Python**: [Python 3.10](https://www.python.org/downloads/) or newer

### Installation

1. **Install Docker** (if not already installed):

    Follow the steps for your OS from the [official Docker installation guide](https://docs.docker.com/engine/install/) or contact your system administrator.

1. **Create and activate a virtual environment:**

   ```bash
   python3.10 -m venv .venv
   source .venv/bin/activate
   ```

1. **Install PatchWise:**

   ```bash
   pip install patchwise
   ```

1. **Set up your API key** (for AI reviews):

   ```bash
   export OPENAI_API_KEY=<your-api-key>
   ```

   Add this line to your shell profile (e.g., `~/.bashrc` or `~/.zshrc`) for persistence.

1. **Verify installation:**

   ```bash
   patchwise --help
   ```

---

## Usage

### Basic Usage

Run PatchWise in the root of your kernel workspace:

```bash
# Review the HEAD commit with all available tools
patchwise

# Review a specific commit
patchwise --commits <commit-sha>

# Review a range of commits
patchwise --commits <start-sha>..<end-sha>

# Run specific review tools
patchwise --reviews checkpatch sparse dt_check
```

### Advanced Usage

```bash
# AI-only reviews with specific model
patchwise --reviews ai_code_review llm_commit_audit --model openai/gpt-4

# Custom repository path
patchwise --repo-path /path/to/kernel --commits HEAD~5..HEAD

# Verbose logging for troubleshooting
patchwise --log-level DEBUG
```

### Example Workflow

```bash
# Set up environment
python3.10 -m venv .venv
source .venv/bin/activate
pip install patchwise

# Configure AI API key (if using AI reviews)
export OPENAI_API_KEY=<your-api-key>

# Navigate to your kernel workspace
cd linux-next

# Apply your patch if not already applied
git am < your-patch.patch

# Run comprehensive review
patchwise

# Or run targeted analysis
patchwise --reviews checkpatch ai_code_review --commits HEAD
```

---

## Command-Line Options

### General Options

- `-h`, `--help`: Show help message and exit

### Patch Review Options

- `--commits`: Space separated list of commit SHAs/refs, or a single commit range in start..end format. (default: [`HEAD`])
- `--repo-path`: Path to the kernel workspace root. Uses your current directory if not specified. (default: `$PWD`)
- `--reviews`: Space-separated list of reviews to run. Available: `checkpatch`, `sparse`, `coccicheck`, `dt_check`, `dtbs_check`, `ai_code_review`, `llm_commit_audit` (default: all available reviews)

### AI Review Options

- `--model`: Specify the AI model to use for code review (default: `openai/Pro`)
- `--provider`: The base URL for the AI model API (default: `https://api.openai.com/v1`)
- `--api-key`: The API key for the AI model API. If not provided, it will be read from the `OPENAI_API_KEY` environment variable or the environment variable corresponding to your selected provider. For additional information on how LiteLLM handles API keys, see [LiteLLM documentation](https://docs.litellm.ai/docs/set_keys#setting-api-keys).

### Logging Options

- `--log-level`: Set the logging level. Options: `DEBUG`, `INFO`, `WARNING`, `ERROR` (default: `INFO`)
- `--log-file`: Path to the log file (default: `<package_path>/sandbox/patchwise.log`)

---

## Development

If you'd like to develop new features or fix existing issues:

- Fork the repository and create a new branch for your changes.
- Make your changes with clear, descriptive commit messages.
- Ensure your code follows the project's coding standards and passes all tests.
- Submit a pull request (PR) with a detailed description of your changes to pull your changes into the staging branch in the main repository.

Please make sure to follow our contribution guidelines before submitting a pull request. [CONTRIBUTING.md](CONTRIBUTING.md)

## Getting in Contact

- [Report an Issue on GitHub](../../issues/new/choose)
- [Open a Discussion on GitHub](../../discussions/new/choose)
- [E-mail us](mailto:dgantman@quicinc.com) for general questions

## License

PatchWise is licensed under the BSD-3-clause License. See [LICENSE.txt](LICENSE.txt) for the full license text.
