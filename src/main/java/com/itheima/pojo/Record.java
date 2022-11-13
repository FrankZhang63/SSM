package com.itheima.pojo;

public class Record {
    private int id;
    private String username;
    private String goodsimage;
    private String goodsprice;
    private String buynum;
    private String buytime;
    private String isbuy;

    @Override
    public String toString() {
        return "Record{" +
                "id=" + id +
                ", username='" + username + '\'' +
                ", goodsimage='" + goodsimage + '\'' +
                ", goodsprice='" + goodsprice + '\'' +
                ", buynum='" + buynum + '\'' +
                ", buytime='" + buytime + '\'' +
                ", isbuy='" + isbuy + '\'' +
                '}';
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getGoodsimage() {
        return goodsimage;
    }

    public void setGoodsimage(String goodsimage) {
        this.goodsimage = goodsimage;
    }

    public String getGoodsprice() {
        return goodsprice;
    }

    public void setGoodsprice(String goodsprice) {
        this.goodsprice = goodsprice;
    }

    public String getBuynum() {
        return buynum;
    }

    public void setBuynum(String buynum) {
        this.buynum = buynum;
    }

    public String getBuytime() {
        return buytime;
    }

    public void setBuytime(String buytime) {
        this.buytime = buytime;
    }

    public String getIsbuy() {
        return isbuy;
    }

    public void setIsbuy(String isbuy) {
        this.isbuy = isbuy;
    }
}
