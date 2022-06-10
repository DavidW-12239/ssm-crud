package crud.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import crud.bean.Employee;
import crud.bean.Msg;
import crud.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class EmployeeController {
    @Autowired
    EmployeeService employeeService;

    //single & multi
    @ResponseBody
    @RequestMapping(value = "/emp/{ids}",method = RequestMethod.DELETE)
    public Msg deleteEmp(@PathVariable("ids") String ids){
        if(ids.contains("-")){//delete by batch
            String[] str_ids = ids.split("-");
            List<Integer> del_ids = new ArrayList<>();

            for(String s: str_ids){
                del_ids.add(Integer.parseInt(s));
            }
            employeeService.deleteEmpByBatch(del_ids);
        }else {
            employeeService.deleteEmpById(Integer.parseInt(ids));
        }
        return Msg.success();
    }

    @ResponseBody
    @RequestMapping(value = "/emp/{empId}",method = RequestMethod.PUT)
    public Msg updateEmp(Employee employee){
        employeeService.updateEmp(employee);
        return Msg.success();
    }

    @ResponseBody
    @RequestMapping(value = "/emp/{id}",method = RequestMethod.GET)
    public Msg getEmp(@PathVariable("id") Integer id){
        Employee employee = employeeService.getEmp(id);
        return Msg.success().add("emp", employee);
    }

    @ResponseBody
    @RequestMapping("/checkRepetitive")
    public Msg checkRepetitive(@RequestParam("empName") String empName){
        String regName = "^[a-zA-Z0-9_-]{4,16}$";
        if(!empName.matches(regName)){
            return Msg.fail().add("va_msg", "illegal name!");
        }
        //check repetitive name
        boolean b = employeeService.checkRepetitive(empName);
        if (b){
            return Msg.success();
        }
        else {
            return Msg.fail().add("va_msg", "username occupied!");
        }
    }

    @ResponseBody
    @RequestMapping(value = "/emp", method = RequestMethod.POST)
    public Msg saveEmp(@Valid Employee employee, BindingResult result){
        if(result.hasErrors()){
            Map<String, Object>map = new HashMap<>();
            List<FieldError> errors = result.getFieldErrors();
            for (FieldError error: errors){
                System.out.println("error fields" + error.getField());
                System.out.println("error info" + error.getDefaultMessage());
                map.put(error.getField(), error.getDefaultMessage());
            }
            return Msg.fail().add("errorFields", map);
        }else {
            employeeService.saveEmp(employee);
            return Msg.success();
        }
    }

    @RequestMapping("/emps")
    @ResponseBody //jackson package needed
    public Msg getEmpsWithJson(@RequestParam(value="pn", defaultValue="1") Integer pn){
        //not a paging search
        //import pageHelper
        //invoke pageHelper, page number and the size of each page
        PageHelper.startPage(pn, 5);
        //then the paging search
        List<Employee> emps = employeeService.getAll();
        //use pageInfo to package the result
        //packaging detailed paging info and search result, 5 pages show each time
        PageInfo page = new PageInfo(emps, 5);
        return Msg.success().add("pageInfo", page);
    }



    //@RequestMapping("/emps")
    public String getEmps(@RequestParam(value="pn", defaultValue="1") Integer pn, Model model){
        //not a paging search
        //import pageHelper
        //invoke pageHelper, page number and the size of each page
        PageHelper.startPage(pn, 5);
        //then the paging search
        List<Employee> emps = employeeService.getAll();
        //use pageInfo to package the result
        //packaging detailed paging info and search result, 5 pages show each time
        PageInfo page = new PageInfo(emps, 5);
        model.addAttribute("pageInfo", page);

        return "list";
    }
}
