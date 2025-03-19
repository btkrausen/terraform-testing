## Automated Testing for Terraform training courses

[![Terraform Tests](https://github.com/btkrausen/terraform-testing/actions/workflows/aws_lab_validation.yml/badge.svg)](https://github.com/btkrausen/terraform-testing/actions/workflows/aws_lab_validation.yml)

This repo is designed to test Terraform configurations used across my online training courses. It ensures that configurations work as expected with the latest versions of Terraform, providers, and modules. Tests are done via GitHub Actions and running each module through a `fmt`, `validate`, `init`, and `plan`. Any errors automatically create an issue on the repo, so it sends me an alert so I can resolve them quickly.

I kept it separate from the course repository to avoid confusing students.

## Support My Content Here:

[![Udemy](https://img.shields.io/badge/Udemy-A435F0?style=for-the-badge&logo=Udemy&logoColor=white)](https://btk.me/btk) [![Github Sponsor](https://img.shields.io/badge/sponsor-30363D?style=for-the-badge&logo=GitHub-Sponsors&logoColor=#EA4AAA)](https://github.com/sponsors/btkrausen?frequency=one-time&sponsor=btkrausen)
