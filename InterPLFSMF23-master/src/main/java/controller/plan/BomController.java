package controller.plan;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Arrays;
import java.util.Vector;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import spring.plan.BomInfo;
import spring.dao.PlanDao;

@Controller
@RequestMapping("/ajax")
public class BomController {

    @GetMapping("/prodVal.do")
    public void prodValSubmit(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.print("success");
        request.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=utf-8");
        
        String prodVal = request.getParameter("prodVal");
		
        //String[] prodValArray = (String[]) request.getParameterValues("prodVal");
        
        JSONArray jsonObject = new JSONArray();

        try {
            PlanDao planDAO = new PlanDao();
            Vector<BomInfo> bom = planDAO.getBomList(prodVal);

            JSONArray json1 = new JSONArray();
            JSONArray json2 = new JSONArray();
            JSONArray json3 = new JSONArray();
            JSONArray json4 = new JSONArray();

            for(BomInfo bominfo : bom) {
            	String materNo = bominfo.getMaterNo();
            	int materQty = bominfo.getMaterQty();
                int materprice = bominfo.getMaterPrice();
                int qty = bominfo.getQty();

                json1.add(materNo);
                json2.add(materprice);
                json3.add(materQty);
                json4.add(qty);
            }
            
            jsonObject.add(json1);
            jsonObject.add(json2);
            jsonObject.add(json3);
            jsonObject.add(json4);
            
        } catch (Exception e) {
            e.printStackTrace();
        }

		String jsonStr = jsonObject.toJSONString();
		PrintWriter writer = response.getWriter();
		writer.print(jsonStr);
	
		System.out.print("jsonStr" + jsonStr);
		
    }
}
