#!/usr/bin/env bash
set -euo pipefail

# ホスト鍵が無ければ生成（ビルド時固定を避ける）
/usr/bin/ssh-keygen -A

# 権限の再確認
chown -R dev:dev /home/dev/.ssh
chmod 700 /home/dev/.ssh
chmod 600 /home/dev/.ssh/authorized_keys

# フォアグラウンドで起動
exec /usr/sbin/sshd -D -e