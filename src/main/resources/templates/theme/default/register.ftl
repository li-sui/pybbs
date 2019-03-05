<#include "layout/layout.ftl"/>
<@html page_title="注册" page_tab="register">
<div class="row">
  <div class="col-md-3 hidden-xs"></div>
  <div class="col-md-6">
    <div class="panel panel-info">
      <div class="panel-heading">注册</div>
      <div class="panel-body">
        <form action="" onsubmit="return;" id="form">
          <div class="form-group">
            <label for="username">用户名</label>
            <input type="text" id="username" name="username" class="form-control" placeholder="用户名"/>
          </div>
          <div class="form-group">
            <label for="password">密码</label>
            <input type="password" id="password" name="password" class="form-control" placeholder="密码"/>
          </div>
          <div class="form-group">
            <label for="email">邮箱</label>
            <input type="email" id="email" name="email" class="form-control" placeholder="邮箱"/>
          </div>
          <div class="form-group">
            <label for="captcha">验证码</label>
            <div class="input-group">
              <input type="text" class="form-control" id="captcha" name="captcha" placeholder="验证码"/>
              <span class="input-group-btn">
                <img style="border: 1px solid #ccc;" src="/common/captcha" id="changeCaptcha"/>
              </span>
            </div>
          </div>
          <div class="form-group">
            <button type="button" id="register_btn" class="btn btn-info">注册</button>
          </div>
        </form>
        <#if (!model.isEmpty(site.oauth_github_client_id!) && !model.isEmpty(site.oauth_github_client_secret!))
        || (!model.isEmpty(site.sms_access_key_id!) && !model.isEmpty(site.sms_secret!))>
          <hr>
        </#if>
        <#if !model.isEmpty(site.oauth_github_client_id!) && !model.isEmpty(site.oauth_github_client_secret!)>
          <a href="/oauth/github" class="btn btn-success btn-block"><i class="fa fa-github"></i>&nbsp;&nbsp;通过Github登录/注册</a>
        </#if>
        <#if !model.isEmpty(site.oauth_github_client_id!) && !model.isEmpty(site.oauth_github_client_secret!)>
          <button class="btn btn-primary btn-block" id="mobile_login"><i class="fa fa-mobile"></i>&nbsp;&nbsp;通过手机号登录/注册</button>
        </#if>
      </div>
    </div>
  </div>
  <div class="col-md-3 hidden-xs"></div>
</div>
<script>
  $(function () {
    $("#changeCaptcha").click(function () {
      var date = new Date();
      $(this).attr("src", "/common/captcha?ver=" + date.getTime());
    })
    $("#register_btn").click(function() {
      var username = $("#username").val();
      var password = $("#password").val();
      var email = $("#email").val();
      var captcha = $("#captcha").val();
      if (!username) {
        toast("请输入用户名");
        return;
      }
      if (!password) {
        toast("请输入密码");
        return;
      }
      if (!email) {
        toast("请输入邮箱");
        return;
      }
      if (!captcha) {
        toast("请输入验证码");
        return;
      }
      $.ajax({
        url: '/api/register',
        type: 'post',
        cache: false,
        async: false,
        contentType: 'application/json',
        data: JSON.stringify({
          username: username,
          password: password,
          email: email,
          captcha: captcha,
        }),
        success: function(data) {
          if (data.code === 200) {
            toast("注册成功", "success");
            setTimeout(function () {
              window.location.href = "/";
            }, 700);
          } else {
            toast(data.description);
          }
        }
      })
    })
  })
</script>
</@html>
