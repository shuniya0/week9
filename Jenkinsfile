podTemplate(yaml: '''
    apiVersion: v1
    kind: Pod
    spec:
      containers:
      - name: centos
        image: centos
        env:
        - name: CALCIP
          value: calculator-service.staging.svc.cluster.local
        command:
        - sleep
        args:
        - 99d
      restartPolicy: Never
''') {
    node(POD_LABEL) {
        stage('k8s') {
            git 'https://github.com/shuniya0/week9.git'
            container('centos') {
                stage('start calculator') {
                    sh '''
                    curl -k -v -XPATCH -H "Authorization: Bearer $(cat /var/run/secrets/kubernetes.io/serviceaccount/token)"  -H "Accept: application/json" -H "Content-Type: application/strategic-merge-patch+json" -H "User-Agent: kubectl/v1.21.5 (darwin/amd64) kubernetes/aea7bba" 'https://kubernetes.docker.internal:6443/apis/apps/v1/namespaces/staging/deployments/calculator-deployment?fieldManager=kubectl-client-side-apply' --data '{"spec":{"template":{"spec":{"containers":[{"name":"calculator","image":"leszko/calculator"}]}}}}'
                    curl -k -v -XPATCH -H "Authorization: Bearer $(cat /var/run/secrets/kubernetes.io/serviceaccount/token)"  -H "Accept: application/json" -H "Content-Type: application/strategic-merge-patch+json" -H "User-Agent: kubectl/v1.21.5 (darwin/amd64) kubernetes/aea7bba" 'https://kubernetes.docker.internal:6443/apis/apps/v1/namespaces/staging/deployments/calculator-deployment?fieldManager=kubectl-client-side-apply' --data '{"spec":{"replicas":2}}'
                    '''
                }
                stage('Test Calculator') {
                    sh '''
                    curl -i $CALCIP:8080/sum?a=3\\&b=2
                    curl -i $CALCIP:8080/div?a=21\\&b=3
                    '''
                }                
            }
            /*
            container('gradle') {
                //git 'https://github.com/shuniya0/week8.git'
                stage('Acceptence Testing') {
                    sh '''
                    git clone 'https://github.com/shuniya0/week8.git'
                    cd week8/
                    chmod +x gradlew
                    ./gradlew acceptanceTest -Dcalculator.url=http://$CALCIP:8080
                    '''
                    publishHTML (target: [
    				reportDir: 'week8/build/reports/tests/acceptanceTest',
    				reportFiles: 'index.html',
    				reportName: "Acceptence Report"
                    ])
                }
            }
            */
        }
    }
}
