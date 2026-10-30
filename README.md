# docker-ansible-lint

> **DEPRECATED:** this image is no longer maintained and will not receive updates. ansible-lint is easy to run without it:
>
> - Locally: `pipx install ansible-lint` or `uvx ansible-lint`.
> - In CI: the official [GitHub Action](https://github.com/ansible/ansible-lint#using-ansible-lint-as-a-github-action) or [pre-commit hook](https://ansible.readthedocs.io/projects/lint/configuring/#pre-commit-setup), or `pip install ansible-lint` in a job running a `python` image.
> - As a container: the Ansible community's [`ghcr.io/ansible/community-ansible-dev-tools`](https://github.com/ansible/ansible-dev-tools) image, which includes ansible-lint.

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
~ docker run --rm -v <playbooks_dir>:/app mablanco/ansible-lint --force-color -p ./playbook.yml
```

### Batch check with find

```bash
~ docker run --rm -v <playbooks_dir>:/app mablanco/ansible-lint --force-color -p $(find . -name "*.yml")
```

### Batch check with git ls-files

```bash
~ docker run --rm -v <playbooks_dir>:/app mablanco/ansible-lint --force-color -p $(git ls-files "*.yml")
```

### As Gitlab runner

```yaml
ansible_linting
    stage: lint
    image: mablanco/ansible-lint
    script:
    - *.yml
```
