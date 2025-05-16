"
**This builder has the following steps which does the following:**
**1)** Create a new domian class which inherits from {{gtClass:LcsDomainCollection}} or one of its subclasses. (ex: LxxPerson). Instances of this class (and its subclasses) are 'domain' level objects. The only thing that they are part of is the system. So the collection that roots these instances must be part of the system class or one of its modules.
**2)** Create a new 'Unknown' class. (Ex: LxxUnknownPerson and it is a subclass of LxxPerson)  <-- this is exploritory
**3)** Create a new domain collection class (ex: LxxPersons) that will root the instances of the classes created in the previous steps. This class inherits from {{gtClass:name=LcsDomainCollection}}
**4)** In the new domain class (ex: LxxPerson) create a #parentSlotDefinition is created which allows the instance to point to its parent. For more details on this see {{gtClass:name=LcsGlobalCollectionReferenceSlot}} and  the builder used to generate the parent method {{gtClass:name=LcsGlobalCollectionReferenceSlotBuilder}}.
**5)** Create the slot definition and slot to hold the instance of the domain collection (Ex: LxxPersons). The slot must be defined in a subclass of {{gtClass:name=LcsBaseModule}}
**6)** 

2) If this is a global collection, then the slot for the new collection must be defined in a module class.
     Currently the rule for global collections is that they must live in a module. Modules inherit from  {{gtClass:LcsBaseModule}} .

 **Instance Variables**
 ------------------------
 *globalCollectionModuleClass*
 The module class which the global collection (Ex: LxxPersons) is instantiated.
 
 *unknownClassName* 
 The name of the class which is a paceholder for the domain instance where the domain instance is not yet known. Example: An Author has a person. But the author is created and the person is not yet known. The Author will be created pointing to the Unknown instance. This class is created in step 2.
 
 *protoInstances*
This is an exploritory feature for storing some data from which to create data in the system.
For example, if creating person titles, the protoinstances could contain {{Mr} {Mrs} {Dr}} etc. This would result in the 
"
Class {
	#name : #LcsGlobalDomainClassClassesBuilderJob,
	#superclass : #LcsDomainClassWithGlobalCollectionBuilderJob,
	#instVars : [
		'protoInstances',
		'unknownClassName',
		'buildUnknownClass',
		'subclassNames'
	],
	#category : #'Lcs-SlotTools'
}

{ #category : #command }
LcsGlobalDomainClassClassesBuilderJob >> addSubclassBuilders [
	self subclassNames do: [ :eachName |
		self addJobStep: (
			LcsDomainClassBuilder new
				newClassName: self classPrefix , eachName;
				targetSuperclassName: self newDomainClassName;
				targetPackageName: self targetPackageName)]
]

{ #category : #command }
LcsGlobalDomainClassClassesBuilderJob >> buildJobSteps [
	self addJobStep: self domainClassBuilder.
	self buildUnknownClass ifTrue: [
		self addJobStep: self domainUnknownClassBuilder].
	self addSubclassBuilders.
	self addJobStep: self domainCollectionClassBuilder.
	self addJobStep: self globalCollectionReferenceSlotBuilder.
	self addJobStep: self globalCollectionSlotBuilder.
	self addMemberOfSlotBuilderForTargetClasses.
	self addJobStep: self loaderBuilder.
	self jobSteps buildJobSteps
]

{ #category : #accessing }
LcsGlobalDomainClassClassesBuilderJob >> buildUnknownClass [
	^ buildUnknownClass
]

{ #category : #accessing }
LcsGlobalDomainClassClassesBuilderJob >> buildUnknownClass: aBoolean [ 
	buildUnknownClass := aBoolean
]

{ #category : #accessing }
LcsGlobalDomainClassClassesBuilderJob >> createForPrefix: aPrefix rootName: aRootName withSubclasses: aCollection [ 
	self createForPrefix: aPrefix rootName: aRootName.
	self subclassNames addAll: aCollection
]

{ #category : #configuration }
LcsGlobalDomainClassClassesBuilderJob >> createForRootName: aRootName [
	super createForRootName: aRootName.
	self undefinedClassName: self classPrefix , 'Unknown' , aRootName
]

{ #category : #accessing }
LcsGlobalDomainClassClassesBuilderJob >> createInstances: aCollection [
	aCollection do: [ :each | self protoInstances add: each ]
]

{ #category : #builders }
LcsGlobalDomainClassClassesBuilderJob >> domainClassBuilder [
	^ LcsDomainClassBuilder new
		newClassName: self newDomainClassName;
		targetPackageName: self targetPackageName;
		yourself
]

{ #category : #'builder step' }
LcsGlobalDomainClassClassesBuilderJob >> domainClassBuilderStep [
	^ (self jobSteps stepsWithClass: LcsDomainClassBuilder) first
]

{ #category : #builders }
LcsGlobalDomainClassClassesBuilderJob >> domainClassCodeMemberSlotBuilder: aTargetClass [
	^ LcsMemberOfSlotBuilder new
		target: aTargetClass;
		targetClassName: aTargetClass name;
		slotName: self domainInstanceSlotName;
		collectionSlotName: self globalCollectionSlotName;
		targetModuleClass: self globalCollectionModuleClass;
		addSlotType: self newDomainClassName;
		yourself
]

{ #category : #builders }
LcsGlobalDomainClassClassesBuilderJob >> domainCollectionClassBuilder [
	^ LcsDomainCollectionClassBuilder new
		newClassName: self globalCollectionClassName;
		targetPackageName: self targetPackageName;
		yourself
]

{ #category : #builders }
LcsGlobalDomainClassClassesBuilderJob >> domainUnknownClassBuilder [
	^ LcsUnknownClassBuilder new
		newClassName: self unknownClassName;
		targetSuperclassName: self newDomainClassName;
		targetPackageName: self targetPackageName;
		yourself
]

{ #category : #builders }
LcsGlobalDomainClassClassesBuilderJob >> globalCollectionReferenceSlotBuilder [
	^ LcsGlobalCollectionReferenceSlotBuilder new
		targetClassName: self newDomainClassName;
		collectionSlotName: self globalCollectionSlotName;
		collectionSlotModuleName: self globalCollectionModuleClass defaultModuleName;
		collectionClassName: self globalCollectionClassName; 
		addSlotType: self globalCollectionClassName;
		yourself
]

{ #category : #'builder step' }
LcsGlobalDomainClassClassesBuilderJob >> globalCollectionSlotBuilder [
	^ LcsGlobalSlotDefinitionBuilder new
		slotClassName: self globalCollectionClassName;
		slotName: self globalCollectionSlotName;
		targetClassName: self globalCollectionModuleClass name;
		targetModuleClass: self globalCollectionModuleClass;
		collectionElementTypes: { self newDomainClassName};
		addSlotType: self globalCollectionClassName;
		yourself
]

{ #category : #'builder step' }
LcsGlobalDomainClassClassesBuilderJob >> globalCollectionSlotDefinitionStep [
	^ (self jobSteps stepsWithClass: LcsGlobalSlotDefinitionBuilder) first
]

{ #category : #initialize }
LcsGlobalDomainClassClassesBuilderJob >> initialize [
	super initialize.
	self protoInstances: OrderedCollection new.
	self targetDomainClasses: Set new.
	self buildUnknownClass: false.
	self subclassNames: OrderedCollection new
]

{ #category : #'as yet unclassified' }
LcsGlobalDomainClassClassesBuilderJob >> loaderBuilder [
	^ LcsLoaderClassBuilder new
		newClassName: self globalCollectionClassName , 'Loader';
		instanceClassName: self newDomainClassName;
		targetPackageName: self targetPackageName;
		yourself
]

{ #category : #command }
LcsGlobalDomainClassClassesBuilderJob >> populateSlotModel [
	self globalCollectionSlotDefinitionStep populateSlotModel.
	self currentSystem currentUnitOfWork applyChanges.
	self unknownClass ifNotNil: [ :unknownClass | unknownClass new ].
	"self protoInstances do: [ :each | 
		self domainClassBuilderStep installedClass new
			isoCode: (each at: 1);
			countryName: (each at: 2)]."
	self currentSystem currentUnitOfWork applyChanges.
]

{ #category : #printing }
LcsGlobalDomainClassClassesBuilderJob >> printJobStreamDetailsOn: aStream [
	aStream 
		nextPutAll: 'Install ';
		nextPutAll: self newDomainClassName ; cr;
		nextPutAll: ' with instances stored in ';
		nextPutAll: self globalCollectionClassName
]

{ #category : #accessing }
LcsGlobalDomainClassClassesBuilderJob >> protoInstances [
	^ protoInstances
]

{ #category : #accessing }
LcsGlobalDomainClassClassesBuilderJob >> protoInstances: aCollection [
	protoInstances := aCollection
]

{ #category : #accessing }
LcsGlobalDomainClassClassesBuilderJob >> subclassNames [
	^ subclassNames
]

{ #category : #accessing }
LcsGlobalDomainClassClassesBuilderJob >> subclassNames: anObject [
	subclassNames := anObject
]

{ #category : #accessing }
LcsGlobalDomainClassClassesBuilderJob >> undefinedClassName: anObject [
	unknownClassName := anObject
]

{ #category : #accessing }
LcsGlobalDomainClassClassesBuilderJob >> unknownClass [
	^ self unknownClassBuilderStep ifNotNil: [ :step | step installedClass ]
]

{ #category : #'builder step' }
LcsGlobalDomainClassClassesBuilderJob >> unknownClassBuilderStep [
	^ (self jobSteps stepsWithClass: LcsUnknownClassBuilder) ifEmpty: [ nil ] ifNotEmpty: [ :coll | coll first ]
]

{ #category : #accessing }
LcsGlobalDomainClassClassesBuilderJob >> unknownClassName [
	^ unknownClassName
]

{ #category : #verification }
LcsGlobalDomainClassClassesBuilderJob >> verifyPopulateSlotModel [
	self protoInstances isEmpty 
		ifTrue: [ ]
		ifFalse: [ self subclassResponsibility ]
]
