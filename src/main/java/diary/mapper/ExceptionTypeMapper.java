package diary.mapper;

import diary.common.mapper.SysMapper;
import diary.pojo.ExceptionType;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface ExceptionTypeMapper extends SysMapper<ExceptionType>{
    List<ExceptionType> listExceptionTypeByUserId(@Param("userId") Long userId, @Param("erId") Long erId);
}
