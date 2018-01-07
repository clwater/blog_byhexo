<script async src="https://dn-lbstatics.qbox.me/busuanzi/2.3/busuanzi.pure.mini.js">
</script>


<!-- 不蒜子计数初始值纠正 -->
<script src="//cdn.bootcss.com/jquery/3.2.1/jquery.min.js"></script>
<script>
    $(document).ready(function() {
        var int = setInterval(fixCount, 100);
        var busuanziSiteOffset = 11452;
        var busuanziSitePople = 3037;
        function fixCount() {
            if ($("#busuanzi_container_site_pv").css("display") != "none") {
                clearInterval(int);
                $("#busuanzi_value_site_pv").html(parseInt($("#busuanzi_value_site_pv").html()) + busuanziSiteOffset);
                $("#busuanzi_value_site_uv").html(parseInt($("#busuanzi_value_site_uv").html()) + busuanziSitePople);
            }
        }
    });
</script>


<br/>
<br/>
<br/>

<div class="copyright" >
  {% set current = date(Date.now(), "YYYY") %}
  &copy; {% if theme.since and theme.since != current %} {{ theme.since }} - {% endif %}
  <span itemprop="copyrightYear">{{ current }}</span>
  <span class="with-love">
    <i class="fa fa-{{ theme.authoricon }}"></i>
  </span>
  <span class="author" itemprop="copyrightHolder">{{ config.author }}</span>
</div>
{% if theme.copyright %}
<div class="powered-by">
  {{ __('footer.powered', '<a class="theme-link" href="https://hexo.io">Hexo</a>') }}
</div>
<div class="theme-info">
  {{ __('footer.theme') }} -
  <a class="theme-link" href="https://github.com/iissnan/hexo-theme-next">
    NexT.{{ theme.scheme }}
  </a>
</div>
{% endif %}
<br/>

<span id="busuanzi_container_site_pv" style='display:none'>
    Total:&nbsp&nbsp<span id="busuanzi_value_site_pv"></span>&nbsp&nbspviews.
</span>&nbsp&nbsp&nbsp&nbsp|&nbsp&nbsp&nbsp&nbsp</b>
<span id="busuanzi_container_site_uv" style='display:none'>
    Total:&nbsp&nbsp<span id="busuanzi_value_site_uv"></span>&nbsp&nbsppople.
</span>


