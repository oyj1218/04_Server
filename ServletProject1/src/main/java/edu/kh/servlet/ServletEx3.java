package edu.kh.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ServletEx3 extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		String inputId = req.getParameter("inputId");
		String inputPw1 = req.getParameter("inputPw1");
		String inputPw2 = req.getParameter("inputPw2");
		String inputName = req.getParameter("inputName");
		String inputEmail = req.getParameter("inputEmail");

		String[] color = req.getParameterValues("color");

		resp.setContentType("text/html; charset=UTF-8");

		PrintWriter out = resp.getWriter();

		out.println("<!DOCTYPE html>");
		out.println("<html>");

		out.println("<head>");
		out.println("<title>회원 정보 제출 결과</title>");
		out.println("</head>");

		out.println("<body>");

		out.println("<ul>");

		if (inputPw1.equals(inputPw2)) {
			out.println("<li>아이디 : " + inputId + "</li>");
			out.println("<li>이름 : " + inputName + "</li>");
			out.println("<li>이메일 : " + inputEmail + "</li>");
			if (color != null) {
				out.print("<li>좋아하는 색 : ");
				for (String c : color) {
					out.print(c + " ");
				}
				out.print("</li>");
			} else {
				out.print("<li>없습니다</li>");
			}
		} else {
			out.print("<h1>비밀번호가 일치하지 않습니다.</h1>");
		}

		out.println("</ul>");

		out.println("</body>");

		out.println("</html>");

	}

}