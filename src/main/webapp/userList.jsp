<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>商城</title>
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
            <li class="layui-nav-item" id="shopcar" @click="showshop" ><a href="javascript:void(0);">购物车</a></li>
            <li class="layui-nav-item" id="buylist" @click="showbuylist"><a href="javascript:void(0);">已完成订单</a></li>
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
        <div id="btnNums" style="width: 400px;height: 50px;margin: 0 auto">

        </div>
        <div class="layui-footer" id="layui-footer"><!-- 页面的底部固定栏 -->
            <button id="allbuy" style="float: left;margin:0 20px;" @click="allcheck">全部勾选</button>
            <button id="nobuy" style="float: left" @click="nocheck">取消全部勾选</button>
            总价<span id="summoney" v-bind:sum="sum">{{sum}}</span>
            <button class="layui-btn" style="float: right;margin-right: 100px" id="buy" @click="buyselect" >购买</button>
        </div>
    </div>
</div>
<script>
    listAll = document.getElementById('ListAll')
    btnNums = document.getElementById("btnNums")
    layuifooter = document.getElementById("layui-footer")
    select = document.getElementById("select")
    check = document.getElementsByClassName("check")
    let shuliang = document.getElementsByClassName("shuliang")
    let goodsprice = document.getElementsByClassName("goodsprice")
    let imgg = document.getElementsByClassName('imgg')
    let summoney = document.getElementById("summoney")
    new Vue({
        el:"#la",
        data:{
            num:[],
            sum:0,
        },
        methods:{
            //点击全部勾选，按钮变
            allcheck(){
                for (let i=0;i<check.length;i++){
                check[i].checked = true;
                }
                this.money()
            },
            //点击取消全部勾选
            nocheck(){
                for (let i =0 ;i<check.length;i++){
                check[i].checked = false;
                }
                this.money()
            },
            //算总价功能
            money(){
                let sum = 0
                for (let i=0;i<check.length;i++){
                    if (check[i].checked===true){
                        sum+=shuliang[i].innerHTML*goodsprice[i].innerHTML
                    }
                }
                this.sum=sum
            },
            //展示购物车页面
            showshop(){
                btnNums.style.display="none"
                select.style.display="none"
                layuifooter.style.display="block"
                axios({
                    method: 'get',
                    url: "/showshoplist?username="+"${user.username}"
                }).then((resp) => {
                    let things = resp.data
                    for (let i=0;i<things.length;i++) {
                        this.num[i] = 1
                    }
                    listAll.innerHTML = `<tr>
                                     <th>勾选</th>
                                     <th>序号</th>
                                     <th>图片</th>
                                     <th>单价</th>
                                     <th>数量</th>
                                     <th>操作</th>
                                </tr>`
                    for (let j = 0; j < things.length; j++) {
                        listAll.innerHTML += `
                    <tr>
                        <td><input type="checkbox" class="check"></td>
                        <td>` + (j+1)+ `</td>
                        <td><img class="imgg" src="../upload/` + things[j].goodsimage + `" alt=""></td>
                        <td class="goodsprice">` + things[j].goodsprice + `</td>
                        <td class="shuliang" id="`+(j+1)+`" >`+this.num[j]+`</td>
                        <td>
                            <button class="nadd"> + </button>
                            <button class="nsub"> - </button>
                        </td>
                    </tr>`
                    }
                    let nadds = document.getElementsByClassName('nadd')
                    let nsubs = document.getElementsByClassName('nsub')

                    for (let i=0;i<nadds.length;i++) {
                        nadds[i].onclick = () => {
                            this.num[i]++
                            document.getElementById(i+1).innerHTML = this.num[i]
                            this.money()
                        }
                        nsubs[i].onclick = () => {
                            if(this.num[i]-1 === 0) return
                            this.num[i]--
                            document.getElementById(i+1).innerHTML = this.num[i]
                            this.money()
                        }
                        check[i].onclick = ()=>{
                            this.money()
                        }
                    }
                })
            },
            //购买操作
            buyselect(){
                let s = new Array()
                for (let i=0;i<check.length;i++) {
                    if(check[i].checked){
                        s.push(imgg[i].src.substring(29)+" "+shuliang[i].innerText)
                    }
                }
                if (s.length!==0){
                    axios({
                        method:"get",
                        url:"/buyselect?goods="+s+"&&username="+"${user.username}"+"&&price="+this.sum
                    }).then((resp)=> {
                        let x = resp.data
                        if (x===1){
                            this.showshop()
                            summoney.innerHTML = '0'
                            alert("购买成功")
                        }
                        if (x===0) {
                            alert("请检查余额是否充足")
                        }
                    })
                }else {
                    alert("请选择要购买的商品")
                }
            },
            //展示已完成订单
            showbuylist(){
                axios({
                    method: "get",
                    url:"/showbuylist?username="+"${user.username}"
                }).then(function (resp){
                    let things = resp.data
                    btnNums.style.display="none"
                    select.style.display="none"
                    layuifooter.style.display="none"
                    listAll.innerHTML = `<tr>
                                     <th>序号</th>
                                     <th>图片</th>
                                     <th>单价</th>
                                     <th>数量</th>
                                     <th>购买时间</th>
                                </tr>`
                    for (let j = 0; j < things.length; j++) {
                        listAll.innerHTML += `
                    <tr>
                        <td>` + (j+1)+ `</td>
                        <td><img class="imgg" src="../upload/` + things[j].goodsimage + `" alt=""></td>
                        <td class="goodsprice">` + things[j].goodsprice + `</td>
                        <td class="shuliang">` + things[j].buynum+ `</td>
                        <td>`+things[j].buytime+`</td>
                    </tr>`
                }
            })
        },
    }
    })
</script>
<script>
    let layuifooter = document.getElementById("layui-footer")
    let select = document.getElementById("select")
    let pageBtns = document.getElementsByClassName('btns')
    let listAll = document.getElementById('ListAll')
    let shoplist = document.getElementById("shoplist")
    let shopcar = document.getElementById("shopcar")
    let buylist = document.getElementById("buylist")
    let message = document.getElementById("message")
    let btnNums = document.getElementById("btnNums")
    let check = document.getElementsByClassName("check")
    let inputtext = document.getElementById("inputtext")
    var page=0;
    //预加载操作
    btnNums.style.display="block"
    select.style.display="block"
    layuifooter.style.display="none"
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
        layuifooter.style.display="none"
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
                        <td><button onclick="addshopcar(` + goods[j].id+`,`+goods[j].price + `)">添加购物车</button></td>
                    </tr>
                    `
            }
        })
    }
    //添加购物车操作
    function addshopcar(id,price) {
        console.log(id)
        axios({
            method: "get",
            url: "/addshopcar?id=" + id + "&&username=" + "${user.username}"+"&&price="+price,
        }).then(function (resp) {
            let x = resp.data
            console.log(x)
            if (x == 0) {
                alert("添加购物车成功")
            } else {
                alert("已经在购物车里了")
            }
        })
    }
    //退出操作
    function exit() {
        if (confirm("确认退出码？"))
            location.href = "/exit"
    }
    //模糊查询操作
    function likeselect(){
        btnNums.style.display="none"
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
                        <td><button onclick="addshopcar(` + goods[j].id+`,`+goods[j].price + `)">添加购物车</button></td>
                    </tr>
                    `
                }
            })
        }else{
            showpagelist(page)
        }
        inputtext.value = ""
    }
    //展示个人信息
    function showusermessage(){
        axios({
            method:"get",
            url:"/showusermessage?username="+"${user.username}"
        }).then(function (resp){
            btnNums.style.display="none"
            select.style.display="none"
            layuifooter.style.display="none"
            let things = resp.data
            listAll.innerHTML=`
                    <div style="">
                        <img src="../img/` + things.image + `" alt=""><br>
                        <p>用&nbsp;&nbsp;户&nbsp;&nbsp;名 :`+things.username+`</p>
                        <p>密&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;码 : `+things.password+`</p>
                        <p id="yue">余&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;额 : `+things.balance+`</p>
                        <input id="recharge" type="number" min="0">
                        <button onclick="recharge1()">充值</button>
                    </div>`
            recharge = document.getElementById("recharge")
            yue = document.getElementById("yue")
        })
    }
    //充值
    function recharge1(){
        axios({
            method:"get",
            url:"/recharge?money="+recharge.value+"&&username="+"${user.username}",
        }).then(function (resp){
            yue.innerHTML= `<p id="yue">余&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;额 : `+resp.data+`</p>`
            alert("充值成功")
            recharge.value=""
        })
    }
</script>
</body>
</html>
