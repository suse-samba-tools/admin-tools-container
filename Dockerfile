# Defines the tag for OBS and build script builds:
#!BuildTag: opensuse/admin-tools:latest
#!BuildTag: opensuse/admin-tools:%%MINOR%%
#!BuildTag: opensuse/admin-tools:%%PKG_VERSION%%
#!BuildTag: opensuse/admin-tools:%%PKG_VERSION%%-%RELEASE%

FROM opensuse/tumbleweed
LABEL maintainer="David Mulder <dmulder@suse.com>"

# labelprefix=org.opensuse.admin-tools
LABEL org.opencontainers.image.title="admin-tools"
LABEL org.opencontainers.image.description="Samba Administrative Tools"
LABEL org.opencontainers.image.created="%BUILDTIME%"
LABEL org.opencontainers.image.version="%%PKG_VERSION%%-%RELEASE%"
LABEL org.opencontainers.image.vendor="openSUSE Project"
LABEL org.openbuildservice.disturl="%DISTURL%"
LABEL org.opensuse.reference="registry.opensuse.org/opensuse/admin-tools:%%PKG_VERSION%%-%RELEASE%"
# endlabelprefix

RUN zypper --non-interactive install --no-recommends \
  util-linux \
  "rubygem(yast-rake)" \
  "rubygem(fast_gettext)" \
  catatonit \
  python3-six \
  yast2-python3-bindings \
  yast2-aduc \
  yast2-gpmc \
  yast2-adsi \
  yast2-dns-manager

COPY entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh
COPY admin-tools.py /usr/share/YaST2/clients/admin-tools.py

ENTRYPOINT ["/usr/bin/catatonit", "--", "/entrypoint.sh"]
