FROM jenkins/jenkins:lts

USER root
RUN apt-get update && apt-get install -y lsb-release ca-certificates curl && \
    install -m 0755 -d /etc/apt/keyrings && \
    curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc && \
    chmod a+r /etc/apt/keyrings/docker.asc && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] \
    https://download.docker.com/linux/debian $(. /etc/os-release && echo \"$VERSION_CODENAME\") stable" \
    | tee /etc/apt/sources.list.d/docker.list > /dev/null && \
    apt-get update && apt-get install -y docker-ce-cli && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

USER jenkins

# Skip the installation wizard
ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false

# Install required plugins: JCasC and Job DSL
RUN jenkins-plugin-cli --plugins "configuration-as-code:1569.vb_72405b_80249 job-dsl:1.84 script-security:1251.vfe552ed55f8d structs:324.va_f5d6774f3a_d instance-identity:142.v04572ca_5b_265" 