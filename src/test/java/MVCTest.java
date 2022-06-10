import com.github.pagehelper.PageInfo;
import crud.bean.Employee;
import crud.dao.EmployeeMapper;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = {"classpath:applicationContext.xml",
        "file:src/main/webapp/WEB-INF/dispatcherServlet-servlet.xml"})
public class MVCTest {
    //mock mvc request
    MockMvc mockMVC;

    //import springmvc ioc
    @Autowired
    WebApplicationContext context;

    @Before
    public void initMockMvc(){
        mockMVC = MockMvcBuilders.webAppContextSetup(context).build();
    }

    @Test
    public void testPage() throws Exception {
        //Mock the springmvc request
        MvcResult result = mockMVC.perform(MockMvcRequestBuilders.get("/emps").param("pn","1"))
                .andReturn();
        //if the request succeeds, there will be pageInfo in the request session so that we can verify by it
        MockHttpServletRequest request = result.getRequest();
        PageInfo pi = (PageInfo) request.getAttribute("pageInfo");
        System.out.println("current page: " + pi.getPageNum());
        System.out.println("total page: " + pi.getPages());
        System.out.println("total records: " + pi.getTotal());
        System.out.println("continuely displaying pages");
        int[] nums = pi.getNavigatepageNums();
        for (int i: nums){
            System.out.println(" " + i);
        }
        //get employee data
        List<Employee> list = pi.getList();
        for (Employee employee: list){
            System.out.println("Id: " + employee.getEmpId() + " name: " + employee.getEmpName());
        }
    }

}
