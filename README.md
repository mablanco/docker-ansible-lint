# docker-ansible-lint

Docker image for ansible-lint (<https://github.com/ansible/ansible-lint>), a tool that checks Ansible playbooks for practices and behaviour that could potentially be improved. These analysis can be run from the CLI and inside a CI/CD pipeline (e.g., as a GitLab runner).

This image uses a minimalistic approach. It's built upon Alpine Linux and Python 3, so it has the smallest possible footprint when launched.

## How to use this image

### Show help

```bash
~ docker run --rm mablanco/ansible-lint
```

### Show version

```bash
~ docker run --rm mablanco/ansible-lint --version
```

### Check a playbook

```bash
~ docker run --rm -v <playbooks_dir>:/app mablanco/ansible-lint --force-color playbook.yml
```

### Check a whole project

Pass any option (for example `--force-color`) so ansible-lint runs instead of showing the help. It discovers the playbooks, roles and other Ansible files in the mounted directory:

```bash
~ docker run --rm -v <project_dir>:/app mablanco/ansible-lint --force-color
```

### Machine-readable output

```bash
~ docker run --rm -v <project_dir>:/app mablanco/ansible-lint -f pep8
```

Other formats are `json`, `codeclimate` and `sarif`.

### In a GitLab CI job

The image entrypoint is `ansible-lint`, so GitLab needs it overridden to run the job script:

```yaml
ansible_linting:
  stage: lint
  image:
    name: mablanco/ansible-lint
    entrypoint: [""]
  script:
    - ansible-lint
```
