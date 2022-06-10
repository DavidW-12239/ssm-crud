import crud.bean.Department;
import crud.bean.Employee;
import crud.dao.DepartmentMapper;
import crud.dao.EmployeeMapper;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.UUID;

//Use spring test
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class MapperTest {
    /*@Test
    void testCrud(){
        ApplicationContext ioc = new ClassPathXmlApplicationContext("");
        ioc.getBean(DepartmentMapper.class);
    }*/

    @Autowired
    DepartmentMapper departmentMapper;

    @Autowired
    EmployeeMapper employeeMapper;

    @Autowired
    SqlSession sqlSession;

    @Test
    public void testCrud(){

        //departmentMapper.insertSelective(new Department(null, "developement"));
        //departmentMapper.insertSelective(new Department(null, "QA"));

        //employeeMapper.insertSelective(new Employee(null, "David", "M", "david@crud.com", 1));
        //employeeMapper.insertSelective(new Employee(null, "Alice", "F", "alice@crud.com", 2));
        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
        /*for (int i=0; i<100; i++){
            String uid = UUID.randomUUID().toString().substring(0,5) + "" + i;
            mapper.insertSelective(new Employee(null, uid, "M", uid + "@crud.com", 1));
        }*/
        /*for (int i=0; i<100; i++){
            String uid = UUID.randomUUID().toString().substring(0,5) + "" + i;
            mapper.insertSelective(new Employee(null, uid, "F", uid + "@crud.com", 2));
        }*/
        System.out.println("complete");

    }

    @Test
    public void testSearch(){
        Employee employee = employeeMapper.selectByPrimaryKey(1);
        System.out.println(employee.getEmpName());
    }
}
