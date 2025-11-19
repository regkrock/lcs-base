"
**Aggregation and Composition are subsets of association** meaning they are specific cases of association. In both aggregation and composition object of one class ""owns"" object of another class. But there is a subtle difference:

**Aggregation** implies a relationship where the child can exist independently of the parent. Example: Class (parent) and Student (child). Delete the Class and the Students still exist.

**Composition** implies a relationship where the child cannot exist independent of the parent. Example: House (parent) and Room (child). Rooms don't exist separate to a House.

**Behaviour:**
1) When a child domain object is inserted into this slot, the parent of the child domain object is not changed.
2) When an element (child domain object) of this slot is replaced, the replaced domain object will still exist and is not marked for deletion.
"
Class {
	#name : 'LcsAggregateSlot',
	#superclass : 'LcsDomainObjectSlot',
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'slot model' }
LcsAggregateSlot >> slotVarPut: anObject in: aDomainObject [
	| originalObject |
	self deprecated: 'Need to pass the old value as well'.
	"More work required here as the fact that they were sapped needs to be recorded"
	originalObject := self persistedSlotVarIn: aDomainObject.
	super slotVarPut: anObject in: aDomainObject.
	"self currentUnitOfWork deleteObject: originalObject"
]
