{% if not (theme.duoshuo and theme.duoshuo.shortname) and not theme.duoshuo_shortname %}
  {% if theme.disqus.enable %}

    {% if theme.disqus.count  %}
      <script id="dsq-count-scr" src="https://{{theme.disqus.shortname}}.disqus.com/count.js" async></script>
    {% endif %}

    {% if page.comments %}
      <!-- 替换为点击加载
      <script type="text/javascript">
        var disqus_config = function () {
          this.page.url = '{{ page.permalink }}';
          this.page.identifier = '{{ page.path }}';
          this.page.title = '{{ page.title| addslashes }}';
        };
        var d = document, s = d.createElement('script');
        s.src = 'https://{{theme.disqus.shortname}}.disqus.com/embed.js';
        s.setAttribute('data-timestamp', '' + +new Date());
        (d.head || d.body).appendChild(s);
      </script>
      -->

      <script type="text/javascript">
        var disqus = {
          load : function disqus(){
            if(typeof DISQUS !== 'object') {
              (function () {
                var disqus_config = function () {
                this.page.url = '{{ page.permalink }}';
                this.page.identifier = '{{ page.path }}';
                this.page.title = '{{ page.title| addslashes }}';
                };
                var d = document, s = d.createElement('script');
                s.src = 'https://{{theme.disqus.shortname}}.disqus.com/embed.js';
                s.setAttribute('data-timestamp', '' + +new Date());
                (d.head || d.body).appendChild(s);
                }());
                $('#load-disqus').remove(); ///加载后移除按钮
              }
            }
          }
    </script>
    <script type="text/javascript">
    var livere = {
      load : function livere(){
        if(typeof LIVERE !== 'object') {
          (function () {
            (function(d, s) {
              var j, e = d.getElementsByTagName(s)[0];
              if (typeof LivereTower === 'function') { return; }
              j = d.createElement(s);
              j.src = 'https://cdn-city.livere.com/js/embed.dist.js';
              j.async = true;
              e.parentNode.insertBefore(j, e);
            })(document, 'script');
            }());
            $('#load-livere').remove(); ///加载后移除按钮
          }
        }
      }
    </script>
    {% endif %}


  {% endif %}
{% endif %}
