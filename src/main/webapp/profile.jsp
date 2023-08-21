<%@page import="model.schema.Thread"%>
<%@page import="model.schema.User"%>
<%@page import="model.FetchGenreList"%>
<%@page import="model.schema.Genre"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="description" content="会員制の掲示板サイトです">
        <title></title>
        <style><%@include file="/WEB-INF/css/style.css" %></style>
    </head>
    <body>
       <%
           Integer adminSession = (Integer) session.getAttribute("adminSession");
           Integer loginSession = (Integer) session.getAttribute("loginSession");
           
           boolean isAdmin = false, isLogin = false;
           if (adminSession != null && adminSession != 0) {
               isAdmin = true;
           }
           if (loginSession != null) {
               isLogin = true;
           }
       %>
       <header>
           <div class="header_outer">
               <div class="header_logo">
                   <a href="top" rel="TOPページへ移動">the掲示板</a>
               </div>
               <nav class="header_nav">
                   <ul class="header_menu">
                       <% if (isAdmin) {
                           out.println("<li class=\"header_menu_item\"><a href=\"admin\" rel=\"管理者メニューへ移動\">管理者</a></li>");
                           }
                          if (isLogin) {
                           out.println("<li class=\"header_menu_item\"><a href=\"account_info\" rel=\"会員管理画面へ移動\">管理画面</a></li>");
                           }
                          if (isLogin) {
                              out.println("<li class=\"header_menu_item\">ログイン中</li>");
                          } else {
                              out.println("<li class=\"header_menu_item\"><a href=\"login\" rel=\"ログイン/新規登録画面へ移動\">ログイン/登録</a></li>");
                          }
                       %>
                   </ul>
               </nav>
           </div>
       </header>
       <main>
           <%
               // ユーザー情報と、ユーザーが建てたスレッドのリストを取得する
               User user = (User) request.getAttribute("userInfo");
               ArrayList<Thread> threadList = (ArrayList<Thread>) request.getAttribute("threadList");
           %>
           <div class='profile_thread_container'>
                <div class='profile_container'>
                    <dl class="name_profile_container">
                       <dt>ユーザー名:</dt>
                       <dd class="account_name"><%= user.getUserName() %></dd>
                       <dt>プロフィール:</dt>
                       <dd class="account_profile">
                           <%= user.getProfile() %>
                       </dd>
                   </dl>
                </div>
                <div class="account_thread_container">
                   <div class="account_thread_heading_container">
                       <h2 class="account_thread_heading">作成したスレッド</h2>
                   </div>
                       <ul>
                           <%
                               for (Thread th : threadList) {
                                   out.println("<li><a href='thread?id=" + th.getThreadId() + "'>" + th.getTitle() + "<span>(" + th.getCreateDay() + ")</span>" + "</a></li>");
                               }
                           %>
                       </ul>
               </div>
           </div>
           
       </main>
       <footer>
           <div class="footer_container">
               <div class="footer_inner">
                   <p class="copy_right"><small>&copy; the掲示板</small></p>
                   <%
                       if (isLogin) {
                           out.println("<p class=\"logout_button_wrapper\"><a href=\"logout\" rel=\"ログアウト画面へ移動\">ログアウト</a></p> ");
                       }
                   %>
               </div>
           </div>
       </footer>
    </body>
</html>