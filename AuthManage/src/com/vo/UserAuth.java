package com.vo;
//角色权限表
public class UserAuth {
	//角色权限id
    private Integer userAuthId;
    //角色id
    private Integer userId;
    //权限id
    private Integer authId;

    public UserAuth() {}

	public UserAuth(Integer userAuthId, Integer userId, Integer authId) {
		this.userAuthId = userAuthId;
		this.userId = userId;
		this.authId = authId;
	}

	public Integer getUserAuthId() {
        return userAuthId;
    }

    public void setUserAuthId(Integer userAuthId) {
        this.userAuthId = userAuthId;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Integer getAuthId() {
        return authId;
    }

    public void setAuthId(Integer authId) {
        this.authId = authId;
    }

	@Override
	public String toString() {
		return "UserAuth [userAuthId=" + userAuthId + ", userId=" + userId + ", authId=" + authId + "]";
	}

    
}