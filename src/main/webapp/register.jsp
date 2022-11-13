<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>注册页面</title>
</head>
<style>
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }
    body {
        width: 100%;
        height: 100%;
    }
    .container {
        width: 100%;
        height: 100vh;
        background-color: #ededed;
        display: flex;
        justify-content: center;
        align-items: center;
    }
    .container .box {
        width: 900px;
        height: 550px;
        background: #fff;
        border-radius: 4px;
        position: relative;
    }
    .container .box .transtion-box {
        position: absolute;
        left: 0;
        transition: 0.5s all ease-in-out;
    }
    .container .box .transtion-box .login-box,
    .reg-box {
        width: 640px;
        height: 100%;
        display: flex;
        flex-flow: column nowrap;
        align-items: center;
        padding: 50px 30px;
    }

    .container .box .transtion-box h1 {
        margin-bottom: 35px;
    }
    .container .box .transtion-box section {
        display: flex;
        flex-flow: inherit;
        align-items: inherit;
        width: 100%;
        margin-bottom: 30px;
    }
    .container .box .transtion-box section label {
        font-size: 14px;
        color: #909399;
        text-transform: uppercase;
        margin-bottom: 8px;
    }
    .container .box .transtion-box section input {
        width: 50%;
        outline: 0;
        border: none;
        font-size: 18px;
        color: tomato;
        text-align: center;
        padding: 4px 10px;
        border-bottom: 1px solid rgba(0, 0, 0, 0.4);
    }
    .container .box .transtion-box section span {
        color: rgb(80, 80, 77);
        font-size: 15px;
        cursor: pointer;
        margin-top: 18px;
    }
    .container .box .transtion-box button {
        width: 50%;
        padding: 6px 0;
        text-align: center;
        border: 3px solid #d4af7a;
        border-radius: 20px;
        background: #d4af7a;
        color: #fff;
        font-size: 17px;
        letter-spacing: 6px;
        text-indent: 6px;
        margin-bottom: 15px;
        cursor: pointer;
    }
    .container .box .transferToReg {
        width: 260px;
        height: 100%;
        background: linear-gradient(
                to bottom right,
                #0e92eb 0%,
                #5f90ec 50%,
                #b08fe5 100%
        );
        border-top-right-radius: 4px;
        border-bottom-right-radius: 4px;
        position: absolute;
        left: 640px;
        top: 0;
        display: flex;
        flex-flow: column nowrap;
        align-items: center;
        padding: 50px 0;
        color: white;
        transition: all 1s ease-in-out;
    }
    .container .box .transferToReg .title {
        margin-bottom: 10px;
        transition: all 0.3s ease-in-out;
    }
    .container .box .transferToReg button {
        margin-top: 260px;
        width: 50%;
        padding: 8px 0;
        border-radius: 14px;
        letter-spacing: 10px;
        text-indent: 10px;
        font-size: 18px;
        color: #fff;
        border: 3px solid #fff;
        background: transparent;
        font-weight: 700;
        cursor: pointer;
    }
    .container .box .transferToReg button:hover {
        border: 3px solid #206dfc;
    }
</style>
<body>
    <div class="container">
        <div class="box">
            ${msg}
            <form action="${pageContext.request.getContextPath()}/register" method="post">
            <div class="transtion-box">
                <div class="reg-box">
                    <h1>立即注册</h1>
                    <section>
                        <label>用户名</label>
                        <input type="text" name="username"/>
                    </section>
                    <section>
                        <label>密码</label>
                        <input type="password" name="password"/>
                    </section>
                    <button type="submit">注册</button>
                </div>
            </div>
            </form>
            <div class="transferToReg">
                <h1 class="title">已有帐号？</h1>
                <span class="subTitle">有帐号就登录吧，好久不见了！</span>
                <button type="button" id="transfetBtn" onclick="tologin()">登录</button>
            </div>
        </div>
    </div>
    <script>
        function tologin(){
            location.href="index.jsp";
        }
    </script>
</body>
</html>
