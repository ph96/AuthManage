package com.vo;
//用户组角色关系表
public class GroupRole {
	//用户组角色id
    private Integer goupRoleId;
    //用户组id
    private Integer groupId;
    //角色id
    private Integer roleId;

    public GroupRole() {}

	public GroupRole(Integer goupRoleId, Integer groupId, Integer roleId) {
		this.goupRoleId = goupRoleId;
		this.groupId = groupId;
		this.roleId = roleId;
	}

	public Integer getGoupRoleId() {
        return goupRoleId;
    }

    public void setGoupRoleId(Integer goupRoleId) {
        this.goupRoleId = goupRoleId;
    }

    public Integer getGroupId() {
        return groupId;
    }

    public void setGroupId(Integer groupId) {
        this.groupId = groupId;
    }

    public Integer getRoleId() {
        return roleId;
    }

    public void setRoleId(Integer roleId) {
        this.roleId = roleId;
    }

	
    @Override
	public String toString() {
		return "GroupRole [goupRoleId=" + goupRoleId + ", groupId=" + groupId + ", roleId=" + roleId + "]";
	}
    
}