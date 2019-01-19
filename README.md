<!-- This file was automatically generated by the `build-harness`. Make all changes to `README.yaml` and run `make readme` to rebuild this file. -->

[![Slalom][logo]](https://slalom.com)

# terraform-aws-codecommit [![Build Status](https://api.travis-ci.com/JamesWoolfenden/terraform-aws-codecommit.svg?branch=master)](https://travis-ci.com/JamesWoolfenden/terraform-aws-codecommit) [![Latest Release](https://img.shields.io/github/release/JamesWoolfenden/terraform-aws-codecommit.svg)](https://github.com/JamesWoolfenden/terraform-aws-codecommit/releases/latest)


Terraform module to provision an AWS [`Codecommit`](https://aws.amazon.com/codecommit/) CI/CD system.


---

This project uses the "build-harness" a modified version of the project ["SweetOps"](https://cpco.io/sweetops) from Cloudposse. Sweet indeed.


It's 100% Open Source and licensed under the [APACHE2](LICENSE).










## Usage

Include this repository as a module in your existing terraform code:

```hcl
module "codecommit" {
  source     = "git::https://github.com/jameswoolfenden/terraform-aws-codecommit.git?ref=master"
  default_branch  = "${var.default_branch}"
  repository_name = "${var.repository_name}"
  developer_group = "${var.developer_group}"
  depends_on      = ["${aws_iam_group.developer.group_name}"]
}
```






## Makefile Targets
```
Available targets:

  help/all:                          Display help for all targets
  help/short:                        This help short screen
  help:                              Help screen
  lint:                              Lint terraform code

```
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| default_branch | The name of the default repository branch | string | `master` | no |
| depends_on | This is a way to make a module depends on, which isnt built in. | list | `<list>` | no |
| developer_group | An existing Iam Group to attach the policy permissions to | string | - | yes |
| repository_name | The name of your GIT repository | string | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| clone_url_https | - |
| clone_url_ssh | - |

# Instructions

This modules creates a repo with direct updates to the master denied. Its has been a common DevOps process pattern to use the mainline model or trunk-based development <https://paulhammant.com/2013/04/05/what-is-trunk-based-development/,> however it is with experience that the optimal pattern is of short lived single activity feature branches, YMMV.

To use this repo the expected behaviour is to branch when starting a new piece of work, for example.

`git pull`

`git branch -b feature/JGW-121-Remove-Project-Managers`

Do your work, check-in.
Push to your feature branch.

`git push -u origin feature/JGW-121-Remove-Project-Managers`

Then when your done create a PR and request the merge.

## Details

Creates a group called developer to which the policy is attached.
To use the repo you need to the your users to the group.
## Using Codecommit

To use codecommit you need to set some git config properties for the credential helper:

`git config --global credential.helper '!aws codecommit credential-helper $@'`

`git config --global credential.UseHttpPath true`

And for SSH look at: <https://docs.aws.amazon.com/codecommit/latest/userguide/setting-up-ssh-unixes.html>

Use ssh-keygen and create a key in your home folder called codecommit

`publickey=$(<~/.ssh/codecommit.pub)`

`user=$(aws iam get-user --query 'User.UserName' --output text)`

### On Windows

`$publickey=get-content ~/.ssh/codecommit.pub`

`$user=aws iam get-user --query 'User.UserName'`

On both:
`aws iam upload-ssh-public-key --user-name $user --ssh-public-key-body $publickey`

Get your ssh key id from the previous commands output

`SSHPublicKeyId=$(aws iam list-ssh-public-keys --user-name $user --query 'SSHPublicKeys[*].SSHPublicKeyId' --output text)`

OR

`$SSHPublicKeyId=(aws iam list-ssh-public-keys --user-name $user --query 'SSHPublicKeys[*].SSHPublicKeyId')|convertfrom-json`

Update your config file with:

$gitconfigupdate=@"
Host git-codecommit.*.amazonaws.com
  User $SSHPublicKeyId
IdentityFile ~/.ssh/codecommit
"@
Add-content ~/.ssh/config \$gitconfigupdate

### linux

cat << EOF > ~/.ssh/config
Host git-codecommit.\*.amazonaws.com
User \$SSHPublicKeyId
IdentityFile ~/.ssh/codecommit
EOF

eval \$(ssh-agent -s)
ssh-add codecommit

Test with:
`ssh git-codecommit.us-east-2.amazonaws.com`



## Related Projects

Check out these related projects.

- [terraform-aws-codebuild](https://github.com/jameswoolfenden/terraform-aws-codebuild) - Making a Build pipeline




## Help

**Got a question?**

File a GitHub [issue](https://github.com/jameswoolfenden/terraform-aws-codecommit/issues).



## Terraform Module Development



## Slack Community

You can join the Cloudposse community [Open Source Community][slack] on Slack.

## Contributing

### Bug Reports & Feature Requests

Please use the [issue tracker](https://github.com/jameswoolfenden/terraform-aws-codecommit/issues) to report any bugs or file feature requests.



## Copyrights

Copyright © 2019-2019 [Slalom, LLC](https://slalom.com)






## License

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

See [LICENSE](LICENSE) for full details.

    Licensed to the Apache Software Foundation (ASF) under one
    or more contributor license agreements.  See the NOTICE file
    distributed with this work for additional information
    regarding copyright ownership.  The ASF licenses this file
    to you under the Apache License, Version 2.0 (the
    "License"); you may not use this file except in compliance
    with the License.  You may obtain a copy of the License at

      https://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing,
    software distributed under the License is distributed on an
    "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
    KIND, either express or implied.  See the License for the
    specific language governing permissions and limitations
    under the License.












### Contributors

|  [![James Woolfenden][jameswoolfenden_avatar]][jameswoolfenden_homepage]<br/>[James Woolfenden][jameswoolfenden_homepage] |
|---|

  [jameswoolfenden_homepage]: https://github.com/jameswoolfenden
  [jameswoolfenden_avatar]: https://github.com/jameswoolfenden.png?size=150



[logo]: docs/slalom-logo.png
[website]: https://slalom.com
[github]: https://github.com/jameswoolfenden
[slack]: https://cpco.io/slack
[linkedin]: https://www.linkedin.com/company/slalom-consulting/
[twitter]: https://twitter.com/Slalom

[share_twitter]: https://twitter.com/intent/tweet/?text=terraform-aws-codecommit&url=https://github.com/jameswoolfenden/terraform-aws-codecommit
[share_linkedin]: https://www.linkedin.com/shareArticle?mini=true&title=terraform-aws-codecommit&url=https://github.com/jameswoolfenden/terraform-aws-codecommit
[share_reddit]: https://reddit.com/submit/?url=https://github.com/jameswoolfenden/terraform-aws-codecommit
[share_facebook]: https://facebook.com/sharer/sharer.php?u=https://github.com/jameswoolfenden/terraform-aws-codecommit
[share_googleplus]: https://plus.google.com/share?url=https://github.com/jameswoolfenden/terraform-aws-codecommit
[share_email]: mailto:?subject=terraform-aws-codecommit&body=https://github.com/jameswoolfenden/terraform-aws-codecommit
