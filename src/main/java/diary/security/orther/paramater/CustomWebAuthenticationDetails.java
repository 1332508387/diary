package diary.security.orther.paramater;

import diary.pojo.User;
import org.springframework.security.web.authentication.WebAuthenticationDetails;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public class CustomWebAuthenticationDetails extends WebAuthenticationDetails {
    private final String verifyCode;
    private final String realVerifyCode;
    private User user;
    private HttpSession session;

    public CustomWebAuthenticationDetails(HttpServletRequest request) {
        super(request);
        this.verifyCode = request.getParameter("verifyCode");
        this.realVerifyCode = (String) request.getSession().getAttribute("KAPTCHA_VERIFY_CODE");
        this.user = new User();
        this.user.setUsername(request.getParameter("username"));
        this.user.setPassword(request.getParameter("password"));
        this.session = request.getSession();
    }

    public String getVerifyCode() {
        return this.verifyCode;
    }

    public String getRealVerifyCode() {
        return realVerifyCode;
    }

    public User getUser() {
        return this.user;
    }

    public HttpSession getSession() {
        return this.session;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(super.toString())
                .append("; verifyCode: ").append(this.getVerifyCode())
                .append("; realVerifyCode: ").append(this.getRealVerifyCode());
        return sb.toString();
    }
}
