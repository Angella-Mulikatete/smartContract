

pragma solidity >=0.4.20;
import "hardhat/console.sol";

contract land {

    address public creatorAdmin;
	enum Status { NotExist, Pending, Approved, Rejected }

	struct PropertyDetail {
		Status status;
		uint value;
		address currOwner;
		// address prevOwner;
		// address location;
	}

	// Dictionary of all the properties, mapped using their { propertyId: PropertyDetail } pair.
	mapping(uint => PropertyDetail) public properties;
	mapping(uint => address) public propOwnerChange;

    mapping(address => int) public users;
    mapping(address => bool) public verifiedUsers;

	modifier onlyOwner(uint _propId) {
		require(properties[_propId].currOwner == msg.sender, 'Belongs to that person');
		_;
	}

	modifier verifiedUser(address _user) {
	    require(verifiedUsers[_user],'User is verified');
	    _;
	}

	modifier verifiedAdmin() {
		require(users[msg.sender] >= 2 && verifiedUsers[msg.sender], 'Admin is verified');
		_;
	}

	modifier verifiedSuperAdmin() {
	    require(users[msg.sender] == 3 && verifiedUsers[msg.sender], 'superadmin is verified');
	    _;
	}

	// Initializing the User Contract.
     constructor  ()  {
		creatorAdmin = msg.sender;
		users[creatorAdmin] = 3;
		verifiedUsers[creatorAdmin] = true;
	}

	// Create a new Property.
        function createProperty(uint _propId, uint _value, address _owner) public verifiedAdmin verifiedUser(_owner)  returns (bool)    {
		properties[_propId] = PropertyDetail(Status.Pending, _value, _owner);
		return true;
	}

	// Approve the new Property.
    	function approveProperty(uint _propId) public verifiedSuperAdmin  returns (bool)  {
		require(properties[_propId].currOwner != msg.sender, 'this validates that the creatorAdmin doesnot own the property');
		properties[_propId].status = Status.Approved;
		return true;
	}

	// Reject the new Property.
	 function rejectProperty(uint _propId) public verifiedSuperAdmin  returns (bool)  {
		require(properties[_propId].currOwner != msg.sender,'this validates that the creatorAdmin doesnot own the property'');
		properties[_propId].status = Status.Rejected;
		return true;
	}

	// Request Change of Ownership.
	function changeOwnership(uint _propId, address _newOwner)public onlyOwner(_propId) verifiedUser(_newOwner)  returns (bool)  {
		require(properties[_propId].currOwner != _newOwner, 'The available property of the current owner should not belong to the new owner');
		require(propOwnerChange[_propId] == address(0),'newOwner now owns the property');
		propOwnerChange[_propId] = _newOwner;
		return true;
	}

	// Approve change in Onwership.
	 function approveChangeOwnership(uint _propId) public verifiedSuperAdmin  returns (bool)  {
	    require(propOwnerChange[_propId] != address(0), 'superAdmin approves new owner');
	    properties[_propId].currOwner = propOwnerChange[_propId];
	    propOwnerChange[_propId] = address(0);
	    return true;
	}

	// Change the price of the property.
     function changeValue(uint _propId, uint _newValue) public onlyOwner(_propId)  returns (bool)  {
        require(propOwnerChange[_propId] == address(0),'price has changed');
        properties[_propId].value = _newValue;
        return true;
    }

	// Get the property details.
	 function getPropertyDetails(uint _propId) public view returns (Status, uint, address)  {
		return (properties[_propId].status, properties[_propId].value, properties[_propId].currOwner);
	}

	// Add new user.
	 function addNewUser(address _newUser) public verifiedAdmin  returns (bool)  {
	    require(users[_newUser] == 0, 'initially the user doesnt exist');
	    require(verifiedUsers[_newUser] == false, 'new user value initially is false cz the new user doent exist');
	    users[_newUser] = 1;
	    return true;
	}

	// Add new Admin.
	 function addNewAdmin(address _newAdmin) public verifiedSuperAdmin  returns (bool)  {
	    require(users[_newAdmin] == 0, 'Admin should not be existing');
	    require(verifiedUsers[_newAdmin] == false, 'Admin should not be existing because true means that admin already exists');
	    users[_newAdmin] = 2;
	    return true;
	}

	// Add new SuperAdmin.
	 function addNewSuperAdmin(address _newSuperAdmin) public verifiedSuperAdmin  returns (bool)  {
	    require(users[_newSuperAdmin] == 0, 'superAdmin should not be existing');
	    require(verifiedUsers[_newSuperAdmin] == false, 'superAdmin should not be existing becuse true means that superadmin already exists');
	    users[_newSuperAdmin] = 3;
	    return true;
	}

	// Approve User.
	 function approveUsers(address _newUser) public verifiedSuperAdmin  returns (bool)  {
	    require(users[_newUser] != 0,'A new user should already be existing');
	    verifiedUsers[_newUser] = true;
	    return true;
	}
}
