# dotfiles

## Installation

```sh
curl -fsSL https://raw.githubusercontent.com/CRaLFa/dotfiles/master/install.sh | bash
```

## ローカル設定

秘密情報や業務固有の設定は、このリポジトリに含めず以下のファイルに置く。
どちらも git 管理外で、存在すれば自動的に読み込まれる。

| ファイル | 内容 |
| --- | --- |
| `~/.bashrc.local` | API キーなどの環境変数、業務固有のシェル関数 |
| `~/.gitconfig.local` | 業務固有の Git 設定 (`url.insteadOf` など) |
