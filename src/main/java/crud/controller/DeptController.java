package crud.controller;

import crud.bean.Department;
import crud.bean.Msg;
import crud.service.DeptService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class DeptController {
    @Autowired
    private DeptService deptService;

    @ResponseBody
    @RequestMapping("/depts")
    public Msg getDepts(){
        List<Department> list = deptService.getDepts();
        return Msg.success().add("depts", list);
    }
}
