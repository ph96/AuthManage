package com.vo;
//用户组表
public class UserGroup {
	//用户组id
    private Integer groupId;
    //用户组名称
    private String groupName;
    //用户组code(码)
    private String groupCode;
    //用户组描述
    private String groupDesc;
    //用户组描述
    private String groupState;

    public UserGroup() {}

	public UserGroup(Integer groupId, String groupName, String groupCode, String groupDesc, String groupState) {
		this.groupId = groupId;
		this.groupName = groupName;
		this.groupCode = groupCode;
		this.groupDesc = groupDesc;
		this.groupState = groupState;
	}

	public Integer getGroupId() {
        return groupId;
    }

    public void setGroupId(Integer groupId) {
        this.groupId = groupId;
    }

    public String getGroupName() {
        return groupName;
    }

    public void setGroupName(String groupName) {
        this.groupName = groupName == null ? null : groupName.trim();
    }

    public String getGroupCode() {
        return groupCode;
    }

    public void setGroupCode(String groupCode) {
        this.groupCode = groupCode == null ? null : groupCode.trim();
    }

    public String getGroupDesc() {
        return groupDesc;
    }

    public void setGroupDesc(String groupDesc) {
        this.groupDesc = groupDesc == null ? null : groupDesc.trim();
    }

    public String getGroupState() {
        return groupState;
    }

    public void setGroupState(String groupState) {
        this.groupState = groupState == null ? null : groupState.trim();
    }

	@Override
	public String toString() {
		return "UserGroup [groupId=" + groupId + ", groupName=" + groupName + ", groupCode=" + groupCode
				+ ", groupDesc=" + groupDesc + ", groupState=" + groupState + "]";
	}

    
}