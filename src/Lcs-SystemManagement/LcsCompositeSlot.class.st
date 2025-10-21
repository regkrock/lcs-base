"
**Aggregation and Composition are subsets of association** meaning they are specific cases of association. In both aggregation and composition object of one class ""owns"" object of another class. But there is a subtle difference:

**Aggregation** implies a relationship where the child can exist independently of the parent. Example: Class (parent) and Student (child). Delete the Class and the Students still exist.

**Composition** implies a relationship where the child cannot exist independent of the parent. Example: House (parent) and Room (child). Rooms don't exist separate to a House.

**Behaviour:**
1) When a child domain object is inserted into this slot, the parent of the child domain object must be set to the parent domain object.
2) When an element (child domain object) of this slot is replaced, the replaced domain object should be marked for deletion.
"
Class {
	#name : #LcsCompositeSlot,
	#superclass : #LcsDomainObjectSlot,
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #'slot model' }
LcsCompositeSlot >> slotVarPut: anObject in: aDomainObject [
	| originalObject |
	originalObject := self persistedSlotVarIn: aDomainObject.
	self slotVarPut: anObject in: aDomainObject oldValue: originalObject.
	(originalObject isDomainObject)
		ifTrue: [ self currentUnitOfWork deleteObject: originalObject ]
]
