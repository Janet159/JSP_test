package shop.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import shop.dto.Product;

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
	

}