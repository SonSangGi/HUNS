package kr.co.team2.utils;

import java.io.IOException;
import java.io.Reader;

import com.ibatis.common.resources.Resources;
import com.ibatis.sqlmap.client.SqlMapClient;
import com.ibatis.sqlmap.client.SqlMapClientBuilder;

public class SqlMapClientUtil {
	
		private static SqlMapClient sqlMapClient;
		
		static {
			try {
				Reader reader = Resources.getResourceAsReader("kr/co/team2/mappers/ibatis-config.xml");
				sqlMapClient = SqlMapClientBuilder.buildSqlMapClient(reader);
			} catch (IOException e) {
				// TODO: handle exception
				throw new RuntimeException();
			}
		}
		
		public static SqlMapClient getSqlMapClient() {
			return sqlMapClient;
		}
	}

