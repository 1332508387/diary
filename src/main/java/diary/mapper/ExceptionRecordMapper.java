package diary.mapper;

import diary.common.mapper.SysMapper;
import diary.pojo.ExceptionRecord;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface ExceptionRecordMapper extends SysMapper<ExceptionRecord> {
    List<ExceptionRecord> listExceptionRecord(@Param("userId") Long userId,
                                              @Param("pageIndex") Integer pageIndex,
                                              @Param("pageSize") Integer pageSize,
                                              @Param("keywords") List<String> keywords);

    Integer countByUserId(@Param("userId") Long userId, @Param("keywords") List<String> keywords);

    @Insert("INSERT INTO tb_exception_record_type(er_id, et_id) " +
            "VALUES(#{exceptionRecordId}, #{exceptionTypeId})")
    void saveERIdAndETId(@Param("exceptionRecordId") Long exceptionRecordId,
                         @Param("exceptionTypeId") Long exceptionTypeId);

    @Delete("DELETE FROM tb_exception_record_type WHERE er_id = #{erId}")
    void removeERIdAndETId(Long erId);
}
