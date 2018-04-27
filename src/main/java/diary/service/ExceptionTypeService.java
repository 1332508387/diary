package diary.service;

import diary.mapper.ExceptionTypeMapper;
import diary.pojo.ExceptionType;
import diary.pojo.User;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class ExceptionTypeService extends BaseService<ExceptionType> {
    @Resource
    private ExceptionTypeMapper exceptionTypeMapper;

    public List<ExceptionType> listExceptionTypeByUserId(Long userId, Long erId) {
        ExceptionType exceptionType = new ExceptionType();
        exceptionType.setUserId(userId);
        List<ExceptionType> exceptionTypes = this.exceptionTypeMapper.select(exceptionType);
        //List<ExceptionType> exceptionTypes = this.exceptionTypeMapper.listExceptionTypeByUserId(userId, erId);
        return  exceptionTypes;
    }
}
