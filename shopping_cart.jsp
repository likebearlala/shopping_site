<%@page contentType="text/html"%> 
<%@page pageEncoding="UTF-8"%>
<%@page import = "java.sql.*" %> 
<%@include file = "assets/jsp/consql.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="assets/css/all.css">
    <link rel="stylesheet" href="assets/css/shopping_cart.css">
</head>
<body>
<%
    if(session.getAttribute("email") == null) {
        out.println("請先登入再使用購物車功能, 點<a href='member_center.jsp'>我</a>回登入頁");
    }
    else{
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        String strShoppingCarName = (String)session.getAttribute("strProductNameItroduce");
        String strShoppingCarPrice;
        session.removeAttribute("strProductNameItroduce");
        
        sql="SELECT * FROM `product` WHERE `product_name` = '" + strShoppingCarName + "'";
        ResultSet rs_Product=con.createStatement().executeQuery(sql);


        while(rs_Product.next()){
            session.setAttribute("strShoppingCarPrice", rs_Product.getString("price"));
        }

       // strShoppingCarPrice = session.getAttribute("strShoppingCarPrice").toString();
        strShoppingCarPrice=String.valueOf(session.getAttribute("strShoppingCarPrice")); //物件轉字串型別
%>

    <header class="mainHeader">
        <div class="container">
            <a href="index.jsp" class="logo">
                <img src="assets/img/headphones.png" alt="earphonelogo">
            </a>
            <nav class="navBar">
                <a href="product_overview.jsp">產品介紹</a>
                <a href="member_center.jsp">會員中心</a>
                <a href="managed_server_login.html">後台管理</a>
                <a href="about_us.html">關於我們</a>
                <a href="#" onclick="openNav()">聯絡我們</a>
            </nav>
            <a class="cart" href="shopping_cart.jsp"><img src="assets/img/shopping-cart.png"></a>

            <form class="headerSearch" method="POST" action="search_resultt.jsp">
                <input type="search" name="key_word" placeholder="請輸入產品名稱">
                <button><img src="assets/img/magnifying-glass.png"></button>
            </form>

        </div>
    </header>
<%  
     out.println("<div class='shoppingCart'>");
         out.println("<h2>購物車</h2>");
         out.println("<form method='POST' action=''>");
            out.println("<table border='1'>");
               out.println(" <tbody id='amsTbody'>");
                   out.println("<tr>");
                    out.println("<th>商品名稱</th>");
                    out.println("<th>價格</th>");
                    out.println("<th>數量</th>");
                    out.println("<th>修改數量</th>");
                    out.println("</tr>");                                          


                        int iSum = 0; //總金額
                        int price;
                        int quantity;
                        sql="SELECT * FROM `shopping_car` WHERE `email` = '"+ String.valueOf(session.getAttribute("email")) + "'";
                        ResultSet hr_all=con.createStatement().executeQuery(sql);

                        while(hr_all.next())
                        {

                            out.println("<tr class='tdSet'>");

                            out.println("<td class='tdSet'>"+ hr_all.getString("product_name") +"</td>"); //產品名
                            out.println("<td class='tdSet'>"+ hr_all.getString("price") +"</td>"); //價錢

                            out.println("<td class='tdSet'>");
                                    
                            out.println("<input type='number' value='"+hr_all.getString("car_quantity")+"' min='1' />"); //輸入買多少數量

                            out.println("<td class='deleteCol tdSet'>");
                            out.println("<input type='button' onclick='start()' id='displaysign' name='btt1' value='Edit'/>");
                            out.println("</td>");

                            out.println("</tr>");

                            price = hr_all.getInt("price"); 
                            quantity = hr_all.getInt("car_quantity");
                            iSum+= price * quantity;
                        }
%>
 
                          </tbody>
                <tr>
                    <td class="sum" colspan="4">總計:&nbsp;&nbsp;&nbsp; <%out.println(iSum);%> &nbsp;元</td>
                </tr>
            </table>
        </form>
    </div> 
            

            <form action="assets/jsp/modify_quantity.jsp" method="POST">
            <div class="signform" id="signform" style="display: none">
                <div class="signclose">
                    <img src="assets/img/x-mark.png" width="35px" height="35px" onclick="signclose()">
                </div>

                <div class="userdiv">

                <p>商品名稱:&nbsp;&nbsp;&nbsp;

                    <select name="productName" id="productName">
                <%
                    sql="SELECT `product_name` FROM `shopping_car` WHERE `email`= '"+String.valueOf(session.getAttribute("email"))+"'";
                    
                    ResultSet rsSelectProductName = con.createStatement().executeQuery(sql);

                    while(rsSelectProductName.next()){
                        out.println("<option value='" + rsSelectProductName.getString("product_name") + "'>" + rsSelectProductName.getString("product_name")+ "</option>");
                    }
                %>
                    </select>
                </p>
                </div>
                <div class="pwddiv">
                <p>數量:&nbsp;&nbsp;&nbsp;<input type="number" name="modifyQuantity" value="1" min="1"></p>
                </div>
                <div class="postdiv">
                    <input type="reset" value="重填"/>
                    <input type="submit" value="確認"/>
                </div>
            </div>
        </form>
 

    <div class="address">
        <form action="assets/jsp/address.jsp">
            <table>
                <tr>
                    <td rowspan="2" class="addressCol">收件地址</td>
                    <td class="postalCodeCol"><input class="postalCode" type="text" name="postalCode" placeholder="請輸入郵遞區號"/></td>
                    <td class="cityCol">
                        <select name="city" id="city">
                            <option value="臺北市">臺北市</option>
                            <option value="新北市">新北市</option>
                            <option value="桃園市">桃園市</option>
                            <option value="臺中市">臺中市</option>
                            <option value="臺南市">臺南市</option>
                            <option value="高雄市">高雄市</option>
                            <option value="新竹縣">新竹縣</option>
                            <option value="苗栗縣">苗栗縣</option>
                            <option value="彰化縣">彰化縣</option>
                            <option value="南投縣">南投縣</option>
                            <option value="雲林縣">雲林縣</option>
                            <option value="嘉義縣">嘉義縣</option>
                            <option value="屏東縣">屏東縣</option>
                            <option value="宜蘭縣">宜蘭縣</option>
                            <option value="花蓮縣">花蓮縣</option>
                            <option value="臺東縣">臺東縣</option>
                            <option value="澎湖縣">澎湖縣</option>
                            <option value="金門縣">金門縣</option>
                            <option value="連江縣">連江縣</option>
                            <option value="基隆市">基隆市</option>
                            <option value="新竹市">新竹市</option>
                            <option value="嘉義市">嘉義市</option>
                        </select>
                    </td>
                    <td class="checkoutCol" rowspan="2"><input class="checkout" type="submit" value="結帳  ▶"/></td>
                </tr>
                <tr>
                    <td colspan="2" class="detailedAddressCol"><input class="detailedAddress" type="text" name="detailedAddress" placeholder="請輸入詳細地址"></td>
                </tr>
            </table>
        </form>
    </div>
    <script type="text/javascript" src="assets/js/shopping_cart.js"></script>
    <script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <%
    }
    %>
</body>
</html>