package shop.dto;

import java.sql.Timestamp;

public class ProductIO {

    private int ioNo;            // 입출고번호
    private String productId;    // 상품아이디
    private int orderNo;         // 주문번호
    private int amount;          // 입출고량
    private String type;         // 입고(IN), 출고(OUT)
    private Timestamp ioDate;    // 입출고날짜
    private String userId;       // 회원아이디

    // 기본 생성자
    public ProductIO() {}

    // getter / setter
    public int getIoNo() {
        return ioNo;
    }
    public void setIoNo(int ioNo) {
        this.ioNo = ioNo;
    }
    public String getProductId() {
        return productId;
    }
    public void setProductId(String productId) {
        this.productId = productId;
    }
    public int getOrderNo() {
        return orderNo;
    }
    public void setOrderNo(int orderNo) {
        this.orderNo = orderNo;
    }
    public int getAmount() {
        return amount;
    }
    public void setAmount(int amount) {
        this.amount = amount;
    }
    public String getType() {
        return type;
    }
    public void setType(String type) {
        this.type = type;
    }
    public Timestamp getIoDate() {
        return ioDate;
    }
    public void setIoDate(Timestamp ioDate) {
        this.ioDate = ioDate;
    }
    public String getUserId() {
        return userId;
    }
    public void setUserId(String userId) {
        this.userId = userId;
    }
}

