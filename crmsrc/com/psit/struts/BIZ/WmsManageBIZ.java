package com.psit.struts.BIZ;

import java.util.List;

import com.psit.struts.entity.LimRight;
import com.psit.struts.entity.LimUser;
import com.psit.struts.entity.RStroPro;
import com.psit.struts.entity.RWinPro;
import com.psit.struts.entity.WmsProduct;
import com.psit.struts.entity.WmsStro;
import com.psit.struts.entity.WmsWarIn;
/**
 * 
 * 库存管理BIZ(1) <br>
 *
 * create_date: Aug 11, 2010,2:13:24 PM<br>
 * @author zjr
 */
public interface WmsManageBIZ {
	/**
	 * 
	 * 根据账号查询账号实体 <br>
	 * create_date: Aug 11, 2010,4:15:19 PM <br>
	 * @param code 账号
	 * @return LimUser 账号实体
	 */
	public LimUser findByCode(String code);
	/**
	 * 
	 * 保存仓库 <br>
	 * create_date: Aug 11, 2010,2:16:14 PM <br>
	 * @param wmsStro
	 */
	public void saveWms(WmsStro wmsStro);
	/**
	 * 
	 * 按仓库名称查询仓库列表数量 <br>
	 * create_date: Aug 11, 2010,2:17:18 PM <br>
	 * @param wmsName 仓库名称
	 * @return int 返回仓库列表数量
	 */
	public int getWmsCount(String wmsName);
	/**
	 * 
	 * 按仓库名称查询仓库列表 <br>
	 * create_date: Aug 11, 2010,2:18:09 PM <br>
	 * @param wmsName 仓库名称
	 * @param currentPage 当前页数
	 * @param pageSize 每页数量
	 * @return List 返回仓库列表
	 */
	public List<WmsStro> WmsStroSearch(String wmsName,int currentPage,int pageSize);
	/**
	 * 
	 * 查看仓库详情 <br>
	 * create_date: Aug 11, 2010,2:20:52 PM <br>
	 * @param wmsCode 仓库编号
	 * @return WmsStro 仓库实体
	 */
	public WmsStro findWmsStro(String wmsCode);
	/**
	 * 
	 * 更新仓库 <br>
	 * create_date: Aug 11, 2010,2:21:58 PM <br>
	 * @param wmsStro 仓库实体
	 */
	public void updateWmsStro(WmsStro wmsStro);
	/**
	 * 
	 * 删除仓库 <br>
	 * create_date: Aug 11, 2010,2:22:21 PM <br>
	 * @param wmsStro 仓库实体
	 */
	public void delete(WmsStro wmsStro);
	/**
	 * 
	 * 查询所有已使用的商品类别 <br>
	 * create_date: Aug 11, 2010,2:22:52 PM <br>
	 * @return List 类别列表
	 */
	public List findAllWptType();
	/**
	 * 
	 * 保存商品 <br>
	 * create_date: Aug 11, 2010,2:23:52 PM <br>
	 * @param wmsProduct 商品实体
	 */
	public void saveWP(WmsProduct wmsProduct);
	/**
	 * 
	 * 根据商品id查询商品实体 <br>
	 * create_date: Aug 11, 2010,2:27:26 PM <br>
	 * @param wprId 商品id
	 * @return WmsProduct 返回商品实体
	 */
	public WmsProduct wmsProDesc(Long wprId);
	/**
	 * 
	 * 根据商品的编号查询商品实体 <br>
	 * create_date: Aug 11, 2010,2:28:24 PM <br>
	 * @param wprCode 商品编号
	 * @return List 返回商品列表
	 */
	public List findbyWprCode(String wprCode);
	/**
	 * 
	 * 修改商品信息 <br>
	 * create_date: Aug 11, 2010,2:32:00 PM <br>
	 * @param wmsProduct 商品实体
	 */
	public void wmsProUpdate(WmsProduct wmsProduct);
	/**
	 * 
	 * 删除商品 <br>
	 * create_date: Aug 11, 2010,2:32:16 PM <br>
	 * @param wmsProduct 商品实体
	 */
	public void deletePro(WmsProduct wmsProduct);
	/**
	 * 
	 * 查询仓库列表 <br>
	 * create_date: Aug 11, 2010,2:32:30 PM <br>
	 * @return List 返回仓库列表
	 */
	public List findAllWms();
	/**
	 * 
	 * 保存入库单 <br>
	 * create_date: Aug 11, 2010,2:33:07 PM <br>
	 * @param wmsWarIn 入库单实体
	 */
	public void saveWwi(WmsWarIn wmsWarIn);
	/**
	 * 
	 * 入库单查询列表数量(按入库单主题,仓库编号,审核状态,入库状态,创建日期) <br>
	 * create_date: Aug 11, 2010,2:34:09 PM <br>
	 * @param wwiTitle 入库主题
	 * @param wmsCode 仓库主题
	 * @param wwiAppIsok 审核状态
	 * @param wwiState 入库状态
	 * @param startTime 创建日期(开始)
	 * @param endTime 创建日期(结束)
	 * @return int 返回入库单列表数量
	 */
	public int getWwiCount(String wwiTitle,String wmsCode,String wwiAppIsok,
			String wwiState,String startTime,String endTime);
	/**
	 * 
	 * 入库单查询列表(按入库单主题,仓库编号,审核状态,入库状态,创建日期) <br>
	 * create_date: Aug 11, 2010,2:39:30 PM <br>
	 * @param wwiTitle 入库主题
	 * @param wmsCode 仓库主题
	 * @param wwiAppIsok 审核状态
	 * @param wwiState 入库状态
	 * @param startTime 创建日期(开始)
	 * @param endTime 创建日期(结束)
	 * @param currentPage 当前页数
	 * @param pageSize 每页数量
	 * @return List 返回入库单列表
	 */
	public List WwiSearch(String wwiTitle,String wmsCode,String wwiAppIsok,String wwiState
			,String startTime,String endTime,int currentPage,int pageSize);
	/**
	 * 
	 * 根据入库单Id查询实体 <br>
	 * create_date: Aug 11, 2010,2:40:43 PM <br>
	 * @param wwiId 入库单Id
	 * @return WmsWarIn 返回入库单实体
	 */
	public WmsWarIn findWwi(Long wwiId);
	/**
	 * 
	 * 保存入库明细 <br>
	 * create_date: Aug 11, 2010,2:43:37 PM <br>
	 * @param rwinPro 入库明细实体
	 */
	public void saveRwinPro(RWinPro rwinPro);
	/**
	 * 
	 * 查询所有入库商品 <br>
	 * create_date: Aug 11, 2010,2:44:10 PM <br>
	 * @param wwiId 入库明细id
	 * @return List<RWinPro> 返回入库明细列表
	 */
	public List<RWinPro> findAllRwinPro(Long wwiId);
	/**
	 * 
	 * 保存仓库明细 <br>
	 * create_date: Aug 11, 2010,2:45:31 PM <br>
	 * @param rstroPro 仓库明细实体
	 */
	public void saveRsp(RStroPro rstroPro);
	/**
	 * 
	 * 更新入库单 <br>
	 * create_date: Aug 11, 2010,2:48:41 PM <br>
	 * @param wmsWarIn 入库单实体
	 */
	public void updateWwi(WmsWarIn wmsWarIn);
	/**
	 * 
	 * 根据id查询入库明细实体 <br>
	 * create_date: Aug 11, 2010,2:50:18 PM <br>
	 * @param rwiId 入库明细id
	 * @return RWinPro 返回入库明细实体
	 */
	public RWinPro getRWinPro(Long rwiId);
	/**
	 * 
	 * 更新入库商品 <br>
	 * create_date: Aug 11, 2010,2:51:24 PM <br>
	 * @param rwinPro 入库明细实体
	 */
	public void updateRwp(RWinPro rwinPro);
	/**
	 * 
	 * 删除入库商品 <br>
	 * create_date: Aug 11, 2010,2:53:45 PM <br>
	 * @param rwinPro 入库明细实体
	 */
	public void delRwp(RWinPro rwinPro);
	/**
	 * 
	 * 查询仓库所有商品 <br>
	 * create_date: Aug 11, 2010,2:55:12 PM <br>
	 * @return List 返回仓库明细列表
	 */
	public List findAllRsp();
	/**
	 * 
	 * 更新仓库明细表 <br>
	 * create_date: Aug 11, 2010,2:56:10 PM <br>
	 * @param rsp 仓库明细实体
	 */
	public void updatePsp(RStroPro rsp);
	/**
	 * 
	 * 根据仓库编号查询仓库商品 <br>
	 * create_date: Aug 11, 2010,2:56:36 PM <br>
	 * @param wmsCode 仓库编号
	 * @return List 返回仓库明细列表
	 */
	public List findByWmsCode(String wmsCode);
	/**
	 * 
	 * 删除未入库的入库单 <br>
	 * create_date: Aug 11, 2010,2:59:37 PM <br>
	 * @param wmsWarIn 入库单实体
	 */
	public void deleteWwi(WmsWarIn wmsWarIn);
	/**
	 * 
	 * 根据入库单号删除入库明细 <br>
	 * create_date: Aug 11, 2010,3:00:06 PM <br>
	 * @param wwiCode 入库单号
	 */
	public void delRwinPro(Long wwiCode);
	/**
	 * 
	 * 按商品id,仓库编号查询库存明细列表数量 <br>
	 * create_date: Aug 11, 2010,3:01:40 PM <br>
	 * @param wprCode 商品id
	 * @param wmsCode 仓库编号
	 * @return int 返回库存明细列表数量
	 */
	public int getCountRwp(String wprCode,String wmsCode);
	/**
	 * 
	 * 按商品id,仓库编号查询库存明细列表 <br>
	 * create_date: Aug 11, 2010,3:03:58 PM <br>
	 * @param wprCode 商品id
	 * @param wmsCode 仓库编号
	 * @param currentPage 当前页数
	 * @param pageSize 每页数量
	 * @return List 返回库存明细列表
	 */
	public List rwpSearch(String wprCode,String wmsCode,int currentPage,int pageSize);
	/**
	 * 
	 * 查询所有仓库明细列表数量 <br>
	 * create_date: Aug 11, 2010,3:05:19 PM <br>
	 * @return int 返回库存明细列表数量
	 */
	public int getCountRStroPro();
	/**
	 * 
	 * 查询所有仓库明细列表 <br>
	 * create_date: Aug 11, 2010,3:05:38 PM <br>
	 * @param currentPage 当前页数
	 * @param pageSize 每页数量
	 * @return List 返回库存明细列表
	 */
	public List rStroProSearch(int currentPage,int pageSize);
	/**
	 * 
	 * 按商品名称/型号/编号查询 <br>
	 * create_date: Aug 11, 2010,3:09:15 PM <br>
	 * @param wprName 商品名称/型号/编号
	 * @param agr 是否计算库存标识
	 * @return List 返回商品列表
	 */
	public List proSearch(String wprName,String agr);
	/**
	 * 
	 * 判断商品名称型号是否重复 <br>
	 * create_date: Aug 11, 2010,3:10:34 PM <br>
	 * @param wprName 商品名称
	 * @param wprMod 型号
	 * @return List 返回商品列表
	 */
	public List proCheck(String wprName);
	/**
	 * 
	 * 根据商品id查询商品的库存量 <br>
	 * create_date: Aug 11, 2010,3:12:57 PM <br>
	 * @param wprId 商品id
	 * @return List<RStroPro> 返回库存明细列表
	 */
	public List<RStroPro> rwpSearch(Long wprId);
	/**
	 * 
	 * 查询商品的库存总量 <br>
	 * create_date: Aug 11, 2010,3:14:12 PM <br>
	 * @param wprId 商品id
	 * @return Double 返回库存总量
	 */
	public Double getCountPro(Long wprId);
	/**
	 * 
	 * 查询仓库的库存总量 <br>
	 * create_date: Aug 11, 2010,3:20:00 PM <br>
	 * @param wmsCode 仓库编号
	 * @return int 返回库存总量
	 */
	public int getCountStro(String wmsCode);
	/**
	 * 
	 * 查询指定仓库的入库单 <br>
	 * create_date: Aug 11, 2010,3:20:52 PM <br>
	 * @param wmsCode 仓库编号
	 * @return List 返回入库单列表
	 */
	public List WwiSearch(String wmsCode);
	/**
	 * 
	 * 查询未分类的商品 <br>
	 * create_date: Aug 11, 2010,3:21:37 PM <br>
	 * @return List 返回商品列表
	 */
	public List noTypePro();
	/**
	 * 
	 * 查询入库明细中的商品 <br>
	 * create_date: Aug 11, 2010,3:23:32 PM <br>
	 * @param wprId 商品id
	 * @return List<RWinPro> 返回入库明细列表
	 */
	public List<RWinPro> findByWpr(Long wprId);
	/**
	 * 
	 * 按入库单号和商品id查询入库明细 <br>
	 * create_date: Aug 11, 2010,3:25:55 PM <br>
	 * @param wprId 商品id
	 * @param wwiCode 入库单号
	 * @return List<RWinPro> 返回入库明细列表
	 */
	public List<RWinPro> findByWpr(Long wprId,String wwiCode);
	/**
	 * 
	 * 查询今天要审核的入库单数量 <br>
	 * create_date: Aug 11, 2010,3:27:19 PM <br>
	 * @param wmsCode 仓库编号
	 * @param isok 审核状态
	 * @return int 返回入库单数量
	 */
	public int findApp(String wmsCode,String isok);
	/**
	 * 
	 * 查询今天要入库的入库单 <br>
	 * create_date: Aug 11, 2010,3:28:36 PM <br>
	 * @param wmsCode 仓库编号
	 * @return int 返回入库单数量
	 */
	public int findInWms(String wmsCode);
	/**
	 * 
	 * 获得待删除的所有商品列表 <br>
	 * create_date: Aug 11, 2010,3:29:26 PM <br>
	 * @param pageCurrentNo 当前页数
	 * @param pageSize 每页数量
	 * @return List 返回商品列表
	 */
	public List findDelProduct(int pageCurrentNo, int pageSize);
	/**
	 * 
	 * 获得待删除的所有商品数量 <br>
	 * create_date: Aug 11, 2010,3:30:46 PM <br>
	 * @return int 返回商品列表数量
	 */
	public int findDelProductCount();
	/**
	 * 
	 * 获得待删除的所有入库单 <br>
	 * create_date: Aug 11, 2010,3:31:27 PM <br>
	 * @param pageCurrentNo 当前页数
	 * @param pageSize 每页数量
	 * @return List 返回入库单列表
	 */
	public List findDelWarIn(int pageCurrentNo, int pageSize);
	/**
	 * 
	 * 获得待删除的所有入库单数量 <br>
	 * create_date: Aug 11, 2010,3:34:10 PM <br>
	 * @return int 返回入库单列表数量
	 */
	public int findDelWarInCount();
	/**
	 * 
	 * 带删除状态查出入库单实体 <br>
	 * create_date: Aug 11, 2010,3:34:45 PM <br>
	 * @param wwiId 入库单id
	 * @return WmsWarIn 返回入库单实体
	 */
	public WmsWarIn findWwi2(Long wwiId);
	/**
	 * 
	 * 判断仓库名称是否重复 <br>
	 * create_date: Aug 11, 2010,3:38:34 PM <br>
	 * @param wmsName 仓库名称
	 * @return List 返回仓库列表
	 */
	public List checkWmsName(String wmsName);
	/**
	 * 
	 * 根据入库单号查询 <br>
	 * create_date: Aug 11, 2010,3:39:43 PM <br>
	 * @param wwiCode 入库单号
	 * @return List 返回入库单列表
	 */
	public List findByWwiCode(String wwiCode);
	/**
	 * 
	 * 保存仓库的权限码 <br>
	 * create_date: Aug 11, 2010,3:40:09 PM <br>
	 * @param limRight 权限实体
	 */
	public void savLimRight(LimRight limRight);
	/**
	 * 
	 * 删除仓库对应的权限 <br>
	 * create_date: Aug 11, 2010,3:42:42 PM <br>
	 * @param rigCode 权限编号
	 */
	public void delLimRight(String rigCode);
	/**
	 * 
	 * 根据权限码获得仓库 <br>
	 * create_date: Aug 11, 2010,3:45:12 PM <br>
	 * @param rigCode 权限编号
	 * @return LimRight 返回权限实体
	 */
	public LimRight findLimRight(String rigCode);
	/**
	 * 
	 * 修改权限实体 <br>
	 * create_date: Aug 11, 2010,3:47:32 PM <br>
	 * @param limRight 权限实体
	 */
	public void updLimRight(LimRight limRight);
}