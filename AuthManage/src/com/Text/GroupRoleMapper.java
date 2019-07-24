package com.Text;

import com.vo.GroupRole;
import com.vo.GroupRoleExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface GroupRoleMapper {
    int countByExample(GroupRoleExample example);

    int deleteByExample(GroupRoleExample example);

    int deleteByPrimaryKey(Integer goupRoleId);

    int insert(GroupRole record);

    int insertSelective(GroupRole record);

    List<GroupRole> selectByExample(GroupRoleExample example);

    GroupRole selectByPrimaryKey(Integer goupRoleId);

    int updateByExampleSelective(@Param("record") GroupRole record, @Param("example") GroupRoleExample example);

    int updateByExample(@Param("record") GroupRole record, @Param("example") GroupRoleExample example);

    int updateByPrimaryKeySelective(GroupRole record);

    int updateByPrimaryKey(GroupRole record);
}