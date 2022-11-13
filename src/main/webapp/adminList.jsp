<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>管理员界面</title>
    <!-- 引入 layui.css -->
    <link href="//unpkg.com/layui@2.7.6/dist/css/layui.css" rel="stylesheet">
    <!-- 引入 layui.js -->
    <script src="//unpkg.com/layui@2.7.6/dist/layui.js" charset="utf-8"></script>
    <script src="../js/vue.js"></script>
    <script src="../js/axios-0.18.0.js"></script>
</head>
<body>
<div class="layui-layout layui-layout-admin" id="la">
    <div class="layui-header"><!-- 页面的头部 -->
        <div class="layui-logo"><img src="../img/mihayou.png" alt="" width="50%" style="margin-top: 10px"></div>
        <ul class="layui-nav layui-layout-right">
            <li class="layui-nav-item">
                <a href="javascript:void(0);">
                    <img src="../img/${user.image}" alt="" class="layui-nav-img">
                    <span>${user.username}</span>
                </a>
            </li>
        </ul>

    </div>

    <div class="layui-side layui-bg-black"><!-- 页面的侧边栏 -->
        <ul class="layui-nav layui-nav-tree">
            <li class="layui-nav-item layui-this" id="shoplist" onclick="showpagelist(page)"><a href="javascript:void(0);">商品列表</a></li>
            <li class="layui-nav-item" onclick="add()"><a href="javascript:void(0);">添加商品</a></li>
            <li class="layui-nav-item" id="buylist" onclick="showallbuylist()"><a href="javascript:void(0);">用户订单</a></li>
            <li class="layui-nav-item" id="message" onclick="showusermessage()"><a href="javascript:void(0);">个人信息</a></li>
            <li class="layui-nav-item" onclick="exit()"><a href="javascript:void(0);">退出登录</a></li>
        </ul>

    </div>

    <div class="layui-body" id="layui-body" style="text-align: center"><!-- 页面的主体内容 -->
        <div class="layui-bg-gray" id="select" style="padding: 20px;">

            <div class="layui-col-xs1">
                <div class="layui-form-label">
                    商品查询：
                </div>
            </div>
            <div class="layui-col-xs9">
                <input class="layui-input" placeholder="请输入品牌、类型、或价格" id="inputtext"/>
            </div>
            <div class="layui-btn" style="margin-left: 10px;" onclick="likeselect()">提交查询</div>
        </div>
        <table class="layui-table" id="ListAll">

        </table>
        <form id="form1" class="layui-form" action="${pageContext.request.contextPath}/addshop" method="post" enctype="multipart/form-data">
            <div class="layui-form-item layui-form-text">
                <label class="layui-form-label">商品</label>
                <div class="layui-input-block">
                    <input type="file" id="test1" name="file">
                </div>
            </div>
            <div></div>
            <div class="layui-form-item">
                <label class="layui-form-label">品牌</label>
                <div class="layui-input-block">
                    <input type="text" name="brand" required placeholder="请输入" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">类型</label>
                <div class="layui-input-block">
                    <input type="text" name="type" required  placeholder="请输入" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">价格</label>
                <div class="layui-input-block">
                    <input type="number" name="price" required  placeholder="请输入" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <div class="layui-input-block">
                    <input class="layui-btn" type="submit">
                    <button type="reset" class="layui-btn layui-btn-primary">重置</button>
                </div>
            </div>
        </form>
        <div id="btnNums" style="width: 400px;height: 50px;margin: 0 auto">

        </div>
    </div>
</div>
<script>
    let select = document.getElementById("select")
    let pageBtns = document.getElementsByClassName('btns')
    let listAll = document.getElementById('ListAll')
    let shoplist = document.getElementById("shoplist")
    let buylist = document.getElementById("buylist")
    let message = document.getElementById("message")
    let btnNums = document.getElementById("btnNums")
    let inputtext = document.getElementById("inputtext")
    let form1 = document.getElementById("form1")
    var page=0;
    //预加载操作
    form1.style.display="none"
    btnNums.style.display="block"
    select.style.display="block"
    init()
    //计算按钮
    function init() {
        axios({
            method: "get",
            url: "/selectAllGoods"
        }).then(function (resp) {
            let goods = resp.data, len
            let btnNums = document.getElementById('btnNums')
            if (goods.length % 4 === 0) {
                len = goods.length / 4
            } else {
                len = goods.length / 4 + 1
            }
            for (let i = 1; i <= len; i++) {
                btnNums.innerHTML += `<button class="btns" style="margin-right: 5px">` + i + `</button>`
            }
            //点击切换
            clickbut()
            //初始加载 第0页
            showpagelist(0)
        })
    }
    //点击切换页数
    function clickbut() {
        for (let i = 0; i < pageBtns.length; i++) {
            pageBtns[i].onclick = function () {
                page = i;
                showpagelist(i)
            }
        }
    }
    //分页查询操作
    function showpagelist(i) {
        btnNums.style.display="block"
        select.style.display="block"
        form1.style.display="none"
        axios({
            method: "get",
            url: "/selectPageGoods?pageNum=" + pageBtns[i].innerText
        }).then(function (resp) {
            let goods = resp.data
            listAll.innerHTML = `<tr>
                                     <th>序号</th>
                                     <th>图片</th>
                                     <th>品牌</th>
                                     <th>类型</th>
                                     <th>价格</th>
                                     <th>操作</th>
                                </tr>`
            for (let j = 0; j < goods.length; j++) {
                listAll.innerHTML += `
                    <tr>
                        <td>` + (j+1)+ `</td>
                        <td><img src="../upload/` + goods[j].image + `" alt=""></td>
                        <td>` + goods[j].brand + `</td>
                        <td>` + goods[j].type + `</td>
                        <td>` + goods[j].price + `</td>
                        <td><button onclick="removeshopcar(` + goods[j].id+`)">下架</button></td>
                    </tr>
                    `
            }
        })
    }
    //删除商品
    function removeshopcar(id){
        if (confirm("是否要下架该商品")){
            axios({
                method:"get",
                url:"/removeshopcar?id="+id,
            }).then(function (){
                btnNums.innerHTML=""
                //按钮
                init()
                //展示页面
                showpagelist()
            })
        }
    }
    //模糊查询操作
    function likeselect(){
        btnNums.style.display="none"
        form1.style.display="none"
        let content = inputtext.value
        if(content.trim()!==''){
            axios({
                method:"get",
                url:"/likeselect?content="+content
            }).then(function (resp){
                let goods = resp.data
                console.log(goods)
                listAll.innerHTML = `<tr>
                                     <th>序号</th>
                                     <th>图片</th>
                                     <th>品牌</th>
                                     <th>类型</th>
                                     <th>价格</th>
                                     <th>操作</th>
                                </tr>`
                for (let j = 0; j < goods.length; j++) {
                    listAll.innerHTML += `
                    <tr>
                        <td>` + (j+1)+ `</td>
                        <td><img src="../upload/` + goods[j].image + `" alt=""></td>
                        <td>` + goods[j].brand + `</td>
                        <td>` + goods[j].type + `</td>
                        <td>` + goods[j].price + `</td>
                        <td><button onclick="removeshopcar(` + goods[j].id+`)">下架</button></td>
                    </tr>
                    `
                }
            })
        }else{
            showpagelist(page)
        }
        inputtext.value = ""
    }
    //查看所有人的购买记录
    function showallbuylist(){
        axios({
            method:"get",
            url:"/showallbuylist"
        }).then(function (resp){
            let things = resp.data
            btnNums.style.display="none"
            select.style.display="none"
            form1.style.display="none"
            listAll.innerHTML = `<tr>
                                     <th>序号</th>
                                     <th>用户</th>
                                     <th>图片</th>
                                     <th>单价</th>
                                     <th>数量</th>
                                     <th>购买时间</th>
                                </tr>`
            for (let j = 0; j < things.length; j++) {
                listAll.innerHTML += `
                    <tr>
                        <td>` + (j+1)+ `</td>
                        <td>` +things[j].username+ `</td>
                        <td><img class="imgg" src="../upload/` + things[j].goodsimage + `" alt=""></td>
                        <td class="goodsprice">` + things[j].goodsprice + `</td>
                        <td class="shuliang">` + things[j].buynum+ `</td>
                        <td>`+things[j].buytime+`</td>
                    </tr>`
            }
        })
    }
    //添加商品页面
    function add(){
        btnNums.style.display="none"
        select.style.display="none"
        form1.style.display="block"
        listAll.innerHTML = ""
    }
    //退出操作
    function exit() {
        if (confirm("确认退出码？"))
            location.href = "/exit"
    }
    //个人信息
    //展示个人信息
    function showusermessage(){
        axios({
            method:"get",
            url:"/showusermessage?username="+"${user.username}"
        }).then(function (resp){
            btnNums.style.display="none"
            select.style.display="none"
            let things = resp.data
            listAll.innerHTML=`
                    <div style="">
                        <img src="../img/` + things.image + `" alt=""><br>
                        <p>用&nbsp;&nbsp;户&nbsp;&nbsp;名 :`+things.username+`</p>
                        <p>身份：管理员</p>
                        <p>密&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;码 : `+things.password+`</p>
                    </div>`
            recharge = document.getElementById("recharge")
            yue = document.getElementById("yue")
        })
    }
</script>
</body>
</html>
