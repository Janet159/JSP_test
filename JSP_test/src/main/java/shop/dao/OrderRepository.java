package shop.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import shop.dto.Order;
import shop.dto.Product;

public class OrderRepository extends JDBConnection {
	
	/**
	 * 주문 등록
	 * @param user
	 * @return
	 */
	public int insert(Order order) {
        int result = 0;
        try {
            String sql = "INSERT INTO `order` (ship_name, zip_code, country, address, date, order_pw, user_id, total_price, phone) " +
                         "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

            psmt = con.prepareStatement(sql);
            psmt.setString(1, order.getShipName());
            psmt.setString(2, order.getZipCode());
            psmt.setString(3, order.getCountry());
            psmt.setString(4, order.getAddress());
            psmt.setString(5, order.getDate());
            psmt.setString(6, order.getOrderPw());
            psmt.setString(7, order.getUserId());
            psmt.setInt(8, order.getTotalPrice());
            psmt.setString(9, order.getPhone());

            result = psmt.executeUpdate();
        } catch (SQLException e) {
            System.err.println("주문 등록 중 오류 발생");
            e.printStackTrace();
        }
        return result;
	}

	/**
	 * 최근 등록한 orderNo 
	 * @return
	 */
	public int lastOrderNo() {
        int orderNo = 0;
        try {
            String sql = "SELECT MAX(order_no) AS order_no FROM `order`";
            psmt = con.prepareStatement(sql);
            rs = psmt.executeQuery();

            if (rs.next()) {
                orderNo = rs.getInt("order_no");
            }
        } catch (SQLException e) {
            System.err.println("최근 주문번호 조회 중 오류 발생");
            e.printStackTrace();
        }
        return orderNo;
	}

	
	/**
	 * 주문 내역 조회 - 회원
	 * @param userId
	 * @return
	 */
	public List<Product> list(String userId) {
        List<Product> list = new ArrayList<>();
        try {
            String sql = "SELECT p.* FROM `order` o " +
                         "JOIN product p ON o.order_no = p.order_no " +
                         "WHERE o.user_id = ?";
            psmt = con.prepareStatement(sql);
            psmt.setString(1, userId);
            rs = psmt.executeQuery();

            while (rs.next()) {
                Product product = new Product();
                product.setProductId(rs.getString("product_id"));
                product.setName(rs.getString("name"));
                product.setUnitPrice(rs.getInt("unit_price"));
                product.setDescription(rs.getString("description"));
                product.setManufacturer(rs.getString("manufacturer"));
                product.setCategory(rs.getString("category"));
                product.setUnitsInStock(rs.getLong("units_in_stock"));
                product.setCondition(rs.getString("condition"));
                product.setFile(rs.getString("file"));
                product.setQuantity(rs.getInt("quantity"));
                product.setUserId(rs.getString("user_id"));
                product.setOrderNo(rs.getInt("order_no"));
                product.setType(rs.getString("type"));

                list.add(product);
            }
        } catch (SQLException e) {
            System.err.println("회원 주문 내역 조회 중 오류 발생");
            e.printStackTrace();
        }
        return list;
	}
	
	/**
	 * 주문 내역 조회 - 비회원
	 * @param phone
	 * @param orderPw
	 * @return
	 */
	public List<Product> list(String phone, String orderPw) {
        List<Product> list = new ArrayList<>();
        try {
            String sql = "SELECT p.* FROM `order` o " +
                         "JOIN product p ON o.order_no = p.order_no " +
                         "WHERE o.phone = ? AND o.order_pw = ?";
            psmt = con.prepareStatement(sql);
            psmt.setString(1, phone);
            psmt.setString(2, orderPw);
            rs = psmt.executeQuery();

            while (rs.next()) {
                Product product = new Product();
                product.setProductId(rs.getString("product_id"));
                product.setName(rs.getString("name"));
                product.setUnitPrice(rs.getInt("unit_price"));
                product.setDescription(rs.getString("description"));
                product.setManufacturer(rs.getString("manufacturer"));
                product.setCategory(rs.getString("category"));
                product.setUnitsInStock(rs.getLong("units_in_stock"));
                product.setCondition(rs.getString("condition"));
                product.setFile(rs.getString("file"));
                product.setQuantity(rs.getInt("quantity"));
                product.setUserId(rs.getString("user_id"));
                product.setOrderNo(rs.getInt("order_no"));
                product.setType(rs.getString("type"));

                list.add(product);
            }
        } catch (SQLException e) {
            System.err.println("비회원 주문 내역 조회 중 오류 발생");
            e.printStackTrace();
        }
        return list;
		
	}
	
}






























