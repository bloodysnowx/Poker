function net_holdemresources_web_nashcalculator() {
    var 
        Y = '#',
        $ = '/',
        Z = '?',
        bb = 'baseUrl',
        S = 'begin',
        R = 'bootstrap',
        X = 'end',
        T = 'gwt.codesvr=',
        U = 'gwt.hosted=',
        V = 'gwt.hybrid',
        rb = 'gwt:onPropertyErrorFn',
        ob = 'gwt:property',
        wb = 'iframe',
        _ = 'img',
        xb = "javascript:''",
        Ob = 'loadExternalRefs',
        kb = 'meta',
        zb = 'moduleRequested',
        W = 'moduleStartup',
        Hb = 'msie',
        lb = 'name',
        P = 'net_holdemresources_web_nashcalculator',
        db = 'net_holdemresources_web_nashcalculator.nocache.js',
        mb = 'net_holdemresources_web_nashcalculator::',
        yb = 'position:absolute;width:0;height:0;border:none',
        Gb = 'safari',
        cb = 'script',
        Qb = 'selectingPermutation',
        Q = 'startup',
        eb = 'undefined'
    var l = window,
        m = document,
        n = l.__gwtStatsEvent ? function (a) {
            return l.__gwtStatsEvent(a)
        } : null,
        o = l.__gwtStatsSessionId ? l.__gwtStatsSessionId : null,
        p, q, r, s = '',
        t = {}, u = [],
        v = [],
        w = [],
        x = 0,
        y, z;
    n && n({
        moduleName: P,
        sessionId: o,
        subSystem: Q,
        evtGroup: R,
        millis: (new Date).getTime(),
        type: S
    });
    if (!l.__gwt_stylesLoaded) {
        l.__gwt_stylesLoaded = {}
    }
    if (!l.__gwt_scriptsLoaded) {
        l.__gwt_scriptsLoaded = {}
    }

    function A() {
        var b = false;
        try {
            var c = l.location.search;
            return (c.indexOf(T) != -1 || (c.indexOf(U) != -1 || l.external && l.external.gwtOnLoad)) && c.indexOf(V) == -1
        } catch (a) {}
        A = function () {
            return b
        };
        return b
    }

    function B() {
        if (p && q) {
            var b = m.getElementById(P);
            var c = b.contentWindow;
            if (A()) {
                c.__gwt_getProperty = function (a) {
                    return G(a)
                }
            }
            net_holdemresources_web_nashcalculator = null;
            c.gwtOnLoad(y, P, s, x);
            n && n({
                moduleName: P,
                sessionId: o,
                subSystem: Q,
                evtGroup: W,
                millis: (new Date).getTime(),
                type: X
            })
        }
    }

    function C() {
        function e(a) {
            var b = a.lastIndexOf(Y);
            if (b == -1) {
                b = a.length
            }
            var c = a.indexOf(Z);
            if (c == -1) {
                c = a.length
            }
            var d = a.lastIndexOf($, Math.min(c, b));
            return d >= 0 ? a.substring(0, d + 1) : ''
        }

        function f(a) {
            if (a.match(/^\w+:\/\//)) {} else {
                var b = m.createElement(_);
                b.src = a + 'clear.cache.gif';
                a = e(b.src)
            }
            return a
        }

        function g() {
            var a = E('baseUrl');
            if (a != null) {
                return a
            }
            return ''
        }

        function h() {
            var a = m.getElementsByTagName(cb);
            for (var b = 0; b < a.length; ++b) {
                if (a[b].src.indexOf(db) != -1) {
                    return e(a[b].src)
                }
            }
            return ''
        }

        function i() {
            var a;
            if (typeof isBodyLoaded == eb || !isBodyLoaded()) {
                var b = '__gwt_marker_net_holdemresources_web_nashcalculator';
                var c;
                m.write('<script id="' + b + '"><\/script>');
                c = m.getElementById(b);
                a = c && c.previousSibling;
                while (a && a.tagName != 'SCRIPT') {
                    a = a.previousSibling
                }
                if (c) {
                    c.parentNode.removeChild(c)
                }
                if (a && a.src) {
                    return e(a.src)
                }
            }
            return ''
        }

        function j() {
            var a = m.getElementsByTagName('base');
            if (a.length > 0) {
                return a[a.length - 1].href
            }
            return ''
        }
        var k = g();
        if (k == '') {
            k = h()
        }
        if (k == '') {
            k = i()
        }
        if (k == '') {
            k = j()
        }
        if (k == '') {
            k = e(m.location.href)
        }
        k = f(k);
        s = k;
        return k
    }

    function D() {
        var b = document.getElementsByTagName(kb);
        for (var c = 0, d = b.length; c < d; ++c) {
            var e = b[c],
                f = e.getAttribute(lb),
                g;
            if (f) {
                f = f.replace(mb, '');
                if (f.indexOf('::') >= 0) {
                    continue
                }
                if (f == ob) {
                    g = e.getAttribute('content');
                    if (g) {
                        var h, i = g.indexOf('=');
                        if (i >= 0) {
                            f = g.substring(0, i);
                            h = g.substring(i + 1)
                        } else {
                            f = g;
                            h = ''
                        }
                        t[f] = h
                    }
                } else if (f == rb) {
                    g = e.getAttribute('content');
                    if (g) {
                        try {
                            z = eval(g)
                        } catch (a) {
                            alert('Bad handler "' + g + '" for "gwt:onPropertyErrorFn"')
                        }
                    }
                } else if (f == 'gwt:onLoadErrorFn') {
                    g = e.getAttribute('content');
                    if (g) {
                        try {
                            y = eval(g)
                        } catch (a) {
                            alert('Bad handler "' + g + '" for "gwt:onLoadErrorFn"')
                        }
                    }
                }
            }
        }
    }

    function E(a) {
        var b = t[a];
        return b == null ? null : b
    }

    function F(a, b) {
        var c = w;
        for (var d = 0, e = a.length - 1; d < e; ++d) {
            c = c[a[d]] || (c[a[d]] = [])
        }
        c[a[e]] = b
    }

    function G(a) {
        var b = v[a](),
            c = u[a];
        if (b in c) {
            return b
        }
        var d = [];
        for (var e in c) {
            d[c[e]] = e
        }
        if (z) {
            z(a, d, b)
        }
        throw null
    }
    var H;

    function I() {
        if (!H) {
            H = true;
            var a = m.createElement(wb);
            a.src = xb;
            a.id = P;
            a.style.cssText = yb;
            a.tabIndex = -1;
            m.body.appendChild(a);
            n && n({
                moduleName: P,
                sessionId: o,
                subSystem: Q,
                evtGroup: W,
                millis: (new Date).getTime(),
                type: zb
            });
            a.contentWindow.location.replace(s + K)
        }
    }
    v['user.agent'] = function () {
        var c = navigator.userAgent.toLowerCase();
        var d = function (a) {
            return parseInt(a[1]) * 1000 + parseInt(a[2])
        };
        if (function () {
            return c.indexOf('opera') != -1
        }()) return 'opera';
        if (function () {
            return c.indexOf('webkit') != -1 || function () {
                if (c.indexOf('chromeframe') != -1) {
                    return true
                }
                if (typeof window['ActiveXObject'] != eb) {
                    try {
                        var b = new ActiveXObject('ChromeTab.ChromeFrame');
                        if (b) {
                            b.registerBhoIfNeeded();
                            return true
                        }
                    } catch (a) {}
                }
                return false
            }()
        }()) return Gb;
        if (function () {
            return c.indexOf(Hb) != -1 && m.documentMode >= 9
        }()) return 'ie9';
        if (function () {
            return c.indexOf(Hb) != -1 && m.documentMode >= 8
        }()) return 'ie8';
        if (function () {
            var a = /msie ([0-9]+)\.([0-9]+)/.exec(c);
            if (a && a.length == 3) return d(a) >= 6000
        }()) return 'ie6';
        if (function () {
            return c.indexOf('gecko') != -1
        }()) return 'gecko1_8';
        return 'unknown'
    };
    u['user.agent'] = {
        gecko1_8: 0,
        ie6: 1,
        ie8: 2,
        ie9: 3,
        opera: 4,
        safari: 5
    };
    net_holdemresources_web_nashcalculator.onScriptLoad = function () {
        if (H) {
            q = true;
            B()
        }
    };
    net_holdemresources_web_nashcalculator.onInjectionDone = function () {
        p = true;
        n && n({
            moduleName: P,
            sessionId: o,
            subSystem: Q,
            evtGroup: Ob,
            millis: (new Date).getTime(),
            type: X
        });
        B()
    };
    D();
    C();
    var J;
    var K;
    if (A()) {
        if (l.external && (l.external.initModule && l.external.initModule(P))) {
            l.location.reload();
            return
        }
        K = 'hosted.html?net_holdemresources_web_nashcalculator';
        J = ''
    }
    n && n({
        moduleName: P,
        sessionId: o,
        subSystem: Q,
        evtGroup: R,
        millis: (new Date).getTime(),
        type: Qb
    });
    if (!A()) {
        try {
            F(['gecko1_8'], '207DB4F7345AA9E94A1B495974F8B073');
            F(['ie8'], '4DD487EBA5F682525A3683B29BC7B2B5');
            F(['opera'], '8E8626D310E6920B274DDCC79B72F2B9');
            F(['ie9'], 'C79BC8DAFE99E0FFCA095727FC309EF0');
            F(['ie6'], 'E0D150C81008EDF605E742D734929739');
            F([Gb], 'F37ACFE9B5111143DB5892184917D9FB');
            J = w[G('user.agent')];
            var L = J.indexOf(':');
            if (L != -1) {
                x = Number(J.substring(L + 1));
                J = J.substring(0, L)
            }
            K = J + '.cache.html'
        } catch (a) {
            return
        }
    }
    var M;

    function N() {
        if (!r) {
            r = true;
            B();
            if (m.removeEventListener) {
                m.removeEventListener('DOMContentLoaded', N, false)
            }
            if (M) {
                clearInterval(M)
            }
        }
    }
    if (m.addEventListener) {
        m.addEventListener('DOMContentLoaded', function () {
            I();
            N()
        }, false)
    }
    var M = setInterval(function () {
        if (/loaded|complete/.test(m.readyState)) {
            I();
            N()
        }
    }, 50);
    n && n({
        moduleName: P,
        sessionId: o,
        subSystem: Q,
        evtGroup: R,
        millis: (new Date).getTime(),
        type: X
    });
    n && n({
        moduleName: P,
        sessionId: o,
        subSystem: Q,
        evtGroup: Ob,
        millis: (new Date).getTime(),
        type: S
    });
    m.write('<script defer="defer">net_holdemresources_web_nashcalculator.onInjectionDone(\'net_holdemresources_web_nashcalculator\')<\/script>')
}
net_holdemresources_web_nashcalculator();
