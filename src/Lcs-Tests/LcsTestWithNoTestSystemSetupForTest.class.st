"
Subclasses in:
1)  the  setUp phase of this test will suspend and save the current system.
2) the tearDwon phase will restore the suspended system.

No test system will be created in the setUp phase.

This is designed for tests that are testing the actual construction of a system

"
Class {
	#name : #LcsTestWithNoTestSystemSetupForTest,
	#superclass : #LcsAbstractDomainTest,
	#category : #'Lcs-Tests-Tests'
}
