package shop.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import shop.dto.Product;
import shop.dto.ProductIO;
import shop.dto.User;

public class ProductIORepository extends JDBConnection {

	/**
	 * 상품 입출고 등록
	 * @param product
	 * @param type
	 * @return
	 */
	public int insert(Product product,  int orderNo, String type, String userId) {
        int result = 0;

        try {
            String sql = "INSERT INTO product_io (order_no, product_id, amount, type, user_id) " +
                         "VALUES (?, ?, ?, ?, ?)";

            psmt = con.prepareStatement(sql);
            psmt.setInt(1, orderNo);
            psmt.setString(2, product.getProductId());
            psmt.setInt(3, product.getQuantity());
            psmt.setString(4, type);
            psmt.setString(5, userId);

            result = psmt.executeUpdate();

        } catch (SQLException e) {
            System.err.println("상품 입출고 등록 중 오류 발생");
            e.printStackTrace();
        }

        return result;
	}
	public List<ProductIO> selectByUserId(String userId) {
	    List<ProductIO> list = new ArrayList<>();

	    String sql = "SELECT io_no, product_id, order_no, amount, type, io_date, user_id "
	               + "FROM product_io "
	               + "WHERE user_id = ? "
	               + "ORDER BY io_date DESC";

	    try {
	        psmt = con.prepareStatement(sql);
	        psmt.setString(1, userId);
	        rs = psmt.executeQuery();

	        while (rs.next()) {
	            ProductIO io = new ProductIO();

	            io.setIoNo(rs.getInt("io_no"));
	            io.setProductId(rs.getString("product_id"));
	            io.setOrderNo(rs.getInt("order_no"));
	            io.setAmount(rs.getInt("amount"));
	            io.setType(rs.getString("type"));
	            io.setIoDate(rs.getTimestamp("io_date"));
	            io.setUserId(rs.getString("user_id"));

	            list.add(io);
	        }
	    } catch (SQLException e) {
	        System.err.println("입출고 내역 조회 중 오류 발생");
	        e.printStackTrace();
	    }

	    return list;
	}

	

}