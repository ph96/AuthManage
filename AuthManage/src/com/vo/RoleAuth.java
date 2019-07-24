package com.vo;
//角色权限表
public class RoleAuth {
	//角色权限id
    private Integer roleAuthId;
    //角色id
    private Integer roleId;
    //权限id
    private Integer authId;

    public RoleAuth() {}

	public RoleAuth(Integer roleAuthId, Integer roleId, Integer authId) {
		this.roleAuthId = roleAuthId;
		this.roleId = roleId;
		this.authId = authId;
	}

	public Integer getRoleAuthId() {
        return roleAuthId;
    }

    public void setRoleAuthId(Integer roleAuthId) {
        this.roleAuthId = roleAuthId;
    }

    public Integer getRoleId() {
        return roleId;
    }

    public void setRoleId(Integer roleId) {
        this.roleId = roleId;
    }

    public Integer getAuthId() {
        return authId;
    }

    public void setAuthId(Integer authId) {
        this.authId = authId;
    }

	
    @Override
	public String toString() {
		return "RoleAuth [roleAuthId=" + roleAuthId + ", roleId=" + roleId + ", authId=" + authId + "]";
	}

    
}