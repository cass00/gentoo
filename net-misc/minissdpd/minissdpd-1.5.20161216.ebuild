# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="6"
inherit toolchain-funcs

DESCRIPTION="MiniSSDP Daemon"
SRC_URI="http://miniupnp.free.fr/files/${P}.tar.gz"
HOMEPAGE="http://miniupnp.free.fr/"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="net-libs/libnfnetlink"

RDEPEND="$DEPEND
	|| ( net-misc/miniupnpd net-libs/miniupnpc )"

PATCHES=( "${FILESDIR}/${PN}-1.2-remove-initd.patch" )

src_compile() {
	emake CC="$(tc-getCC)"
}

src_install () {
	emake PREFIX="${D}" install
	newinitd "${FILESDIR}/${PN}.initd-r2" ${PN}
	newconfd "${FILESDIR}/${PN}.confd" ${PN}
	dodoc Changelog.txt README
	doman minissdpd.1
}
