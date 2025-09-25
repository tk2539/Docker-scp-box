FROM ubuntu:24.04

# 必要最低限: OpenSSHサーバとrsync
RUN apt-get update && apt-get install -y --no-install-recommends \
    openssh-server rsync ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# 非rootユーザー dev を作成
RUN useradd -m -s /bin/bash dev

# SSH 初期ディレクトリ
RUN mkdir -p /var/run/sshd /home/dev/.ssh && chown -R dev:dev /home/dev/.ssh && chmod 700 /home/dev/.ssh

# 公開鍵を配置（必要に応じて後述composeのvolumeで差し替え可）
COPY authorized_keys /home/dev/.ssh/authorized_keys
RUN chown dev:dev /home/dev/.ssh/authorized_keys && chmod 600 /home/dev/.ssh/authorized_keys

# 堅牢化した設定を反映
COPY sshd_config /etc/ssh/sshd_config

# 起動スクリプト
COPY start-sshd.sh /usr/local/bin/start-sshd.sh
RUN chmod +x /usr/local/bin/start-sshd.sh

EXPOSE 22
CMD ["/usr/local/bin/start-sshd.sh"]