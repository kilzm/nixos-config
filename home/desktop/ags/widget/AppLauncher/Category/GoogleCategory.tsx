import { bind, execAsync, Variable } from "astal";
import Category from "./Category";
import Item from "../Item";
import Icons from "../../../lib/icons";

function GoogleCategory(query: Variable<string>) {
    const trimmed = bind(query).as(q => q.startsWith('.') ? q.slice(1).trim() : "")
    function search() {
        execAsync(`xdg-open https://www.google.com/search?q=${trimmed.get().replaceAll(" ", "+")}`)
    }

    const item = <Item
        cssClasses={["google"]}
        iconName={Icons.ui.websearch}
        title={bind(trimmed)}
        onClicked={search}
        canFocus={false}
    />

    return <Category 
        name={"Google"}
        action={search}
        child={item}
    />
}

export default GoogleCategory
